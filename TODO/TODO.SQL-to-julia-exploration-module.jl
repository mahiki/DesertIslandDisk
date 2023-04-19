#=  ================================================================================================
TODO: interactive data module  "Separator"
    This example work shows some steps of pulling DB query data into dataframes, and how
    it might be convenient to store queries in a .sql file, label them with a comment,
    and stack the resulting dataframes in memory with a key.

    additional features:
    large dataframe result should just get written to a temp location accessible by the session.
    send alert if df storage is getting high
    another stack for transformed dataframe results
    clear items from the stack via command
    maybe: pull SQL, write to Arrow into local temp files. return the temp location to a yaml in case you want to revisit those.

    purpose why?
    avoid calling an expensive SQL query multiple times
    get quickly into a Julia dataframes venue for skill building and expressiveness

    notes:
        starburst provides a driver: https://docs.starburst.io/data-consumer/clients/odbc.html
            - want syntax highlight in sql queries, store results to temp
        initialize a struct
        read queries from a nearby sql file, separated by comment key with name
        push the query text into stack with key
        call database with query, return dataframe to stack w same key
        clear an entry from the stack, overwrite previous
=   ===============================================================================================#

using DesertIslandDisk
using DataFrames, Dates, TerminalPager
using ODBC

host = "trino-adhoc.corp.zacs-prod.zg-int.net"
port = "443"
drivername = "trino"
TRINO_CREDS = Dict(
    "user" => ENV["TRINO_USER"]
    , "password"=> ENV["TRINO_PASSWORD"]
    )
driverpath = "/Library/starburst/starburstodbc/lib/libstarburstodbc_sb64-universal.dylib"
official_connstring = "Driver=$(drivername);Host=$(host);Port=$(port);AuthenticationType=LDAP Authentication"

ODBC.adddriver("trino", driverpath)
ODBC.drivers()
conn = ODBC.Connection(official_connstring, TRINO_CREDS["user"], TRINO_CREDS["password"])

df = Dict{String, DataFrame}()
query = Dict()
query["cat"] = "show catalogs;"
query["tz"] = "set time zone 'America/Los_Angeles'"
query["uamloa"] = "describe hive.warehouse.uamloa"

function sendq(querytext)
    df = DBInterface.execute(conn, querytext) |> DataFrame
    return df
end

"""push query results to dataframe by key `queryname`"""
function dff(queryname)
    if ! isdefined(Main, :df)
        global df = df = Dict{String, DataFrame}()
    end
    if haskey(query, queryname)
        df[queryname] = sendq(query[queryname])
    else
        print("No key $(queryname) in 'query' Dict.")
    end
end



# ISOLATE APP DATA WITH 'Mortgages' FILTER #
# ======================================== #
query["filter mortgage"] = """
select
    substring(pagepagepathlevel1, 1, 24)  pagepagepathlevel1
    , count(uniquevisitorid) visitors
    , count(case when eventinfoeventcategory = 'Mortgages' then uniquevisitorid end) visitors_w_mortgage_filter
from
    hive.warehouse.uamloa
where
    date(datadate) between date('2023-01-15') and date('2023-01-21')
group by 1 order by 2 desc
limit 30;"""

dff("filter mortgage")
30×3 DataFrame
 Row │ pagepagepathlevel1    visitors  visitors_w_mortgage_filter
     │ String?               Int64?    Int64?
─────┼────────────────────────────────────────────────────────────
   1 │ /intro/                 173820                      109850
   2 │ /pre-qualify/           103546                       40191
   3 │ /journey/                59575                       27096
   4 │ /self-credit/            41824                       32304
   5 │ /info/                   38952                       22347
   6 │ /property/               35355                       15401
   7 │ /pricing/                35240                       14963
   8 │ /next-steps/             20377                       14329
   9 │ /agent/                  16747                        7724
  10 │ /fha/                    16730                        7640
  11 │ /declarations/           16666                        7668
  12 │ /                        14889                         341
  13 │ /income/                 12391                        8013
  14 │ /credit/                 10678                        6724
  15 │ /submission/              9447                        6090
  16 │ /assets/                  8108                        3781
