#=  ================================================================================================
    Read partitioned dataframes from local or s3 paths.

    TODO:       dataset_root currently works with AbstractPath and S3Path types
                partition labels are detected by a simple regex (not timestamp formats)
                kwargs better
                add column type defintion for partition columns
                prune partions from the read stage via kwarg

    author:     mahiki@users.noreply.github.com
=   ===============================================================================================#
using DataFrames, Pipe, Dates
using FilePathsBase, AWSS3, CSV

"""
    read_partitioned_dataframe_csv(dataset_root, date_format::String, column_types::Dict)

Read and return a dataframe from the root of a local path (AbstractPath) or s3 path (S3Path).
Partition columns are typed as String.
Dataset partitions are detected from regex matches to the path using:

    r"/([\\w]+?)=([\\w-]+?)/"
"""
function read_partitioned_dataframe_csv(dataset_root, date_format::String, column_types::Dict)

    # word/digit column, word/digit value and hyphenated dates
    partition_regex = r"/([\w]+?)=([\w-]+?)/"

    datafiles = @pipe walkpath(dataset_root) |> 
        collect |>
        filter(x -> extension(x) == "csv", _)

    partitions = @pipe datafiles |>
        eachmatch.(partition_regex, convert.(String, _), overlap = true) |>
        collect.(_)

    file_index = [ 
        [ datafiles[i], [ convert.(String, j.captures) for j in partitions[i] ] 
        ] for i in keys(datafiles)
        ]

    # assemble the df with all paritions fro 
    df = DataFrame()

    for i in keys(file_index)
        df_raw = @pipe file_index[i][1] |>
            read(_) |>
            CSV.read(_
                , DataFrame
                , dateformat = date_format
                , types = column_types
            )

        # add partition columns
        for parts in file_index[i][2]
            part_col = parts[1]
            part_val = parts[2]
        
            df_raw[:, "$part_col"] .= part_val
        end

        append!(df, df_raw, cols = :orderequal)
    end

    return df
end
