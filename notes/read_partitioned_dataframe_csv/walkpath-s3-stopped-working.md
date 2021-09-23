# debug partitioned_file_reader
* narrowed the issue down to `FilePathsBase.walkpath`
    * `bytes = read.(S3Path("s3://bucket/dataset/")); CSV.read(bytes,DataFrame)` still works
* best way is to observe the AWSS3 docs, need to pass explicit `AWS.global_aws_config()` thing.
* its a mystery why it stopped working, I didn't update the packages in the project folder.

## TOPLINE
* need to pass `AWSConfig` to `S3Path`, (with correct bucket region) then all is well

## test `walkpath` with no AWSConfig, as before
```sh
s3://test-data/test --recursive
2021-09-19 22:17:33  246 Bytes test/test-37/s3-walkpath/df-data-1.txt
2021-09-19 22:17:45  156 Bytes test/test-37/s3-walkpath/df-data-2.txt
```

```jl
] st
 AWSS3 v0.9.1
 CSV v0.9.3
 DataFrames v1.2.2
 FilePathsBase v0.9.10
 Pipe v1.3.0
 Dates

using  AWSS3, FilePathsBase
dataset_path = "s3://team-data/test/"
# "s3://team-data/test/"

s3_path = S3Path(dataset_path)
# p"s3://team-data/test/"

walkpath(s3_path)
# Channel{S3Path{Nothing}}(128) (empty)

collect(ans)
# ERROR: TaskFailedException
# Stacktrace: <verry very long, AWS package things>

# now it doesnt work
# what config is being used?
AWSS3.get_config(s3_path)
AWS.AWSConfig((AKIA?????????H6, I5j..., 146138512-12-31T23:59:59), "us-east-1", "json")

# so it is using the correct config from default profile and location. 
# not great, passing AWS in wont help I think.
```

some test of other AWSS3 functions
```jl
aws = global_aws_config(; region = "us-east-1")
s3_obj = S3Path("s3://axam-data/test/AXAM-37/s3-walkpath/df-data-1.txt", config = aws)
stat(s3_obj)
AWSS3.s3_get_file("axam-data", "test/AXAM-37/s3-walkpath/df-data-1.txt", "df_data-1_downloaded.txt")
shell> ls -la
# -rw-r--r-- 1 merlinr staff  246 Sep 21 23:48 df_data-1_downloaded.txt
```

## test `walkpath` with explicit AWSConfig
```jl
using AWS, AWSS3, FilePathsBase
aws = global_aws_config(; region = "us-east-1")
s3_path = S3Path("s3://axam-data/test/", config = aws)
collect(walkpath(s3_path))
# 4-element Vector{S3Path{AWSConfig}}:
#  p"s3://axam-data/test/AXAM-37/"
#  p"s3://axam-data/test/AXAM-37/s3-walkpath/"
#  p"s3://axam-data/test/AXAM-37/s3-walkpath/df-data-1.txt"
#  p"s3://axam-data/test/AXAM-37/s3-walkpath/df-data-2.txt"
```

**OK: fine it works then**

Just use the AWS config explicitly.

## test `read_partitioned_dataframe_csv` with prod data
```julia
using AWS, DataFrames, CSV
# define dataset path components from M2M3..jl
df_new = read_partitioned_dataframe_csv(
           S3Path(date_partitioned_root, config = aws)
           , "yyyy-mm-dd"
           , Dict(:period_end_dt => Date)
           )
55919×16 DataFrame
```

**DONE**


## upgrade packages and pin
```jl
] upgrade
using AWS, AWSS3, FilePathsBase, DataFrames, CSV, Dates

# define dataset paths from M2M3
include("src/read_partitioned_dataframe_csv.jl")

df_new = read_partitioned_dataframe_csv(
                  S3Path(date_partitioned_root, config = aws)
                  , "yyyy-mm-dd"
                  , Dict(:period_end_dt => Date)
                  )
55919×16 DataFrame
```

## DONE