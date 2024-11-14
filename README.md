# BI Recruitment Task

This repo provide a set of preconfigured tools that can be used for the recruitment task for IFT:

* PostgreSQL database
* DBT
* Grafana

## Tasks

One goal of the BI team is to design and implement dashboards to help Projects Lead have an overview of their project.
Those dashboards will be use for the progress reporting, evaluating the project adoption, and identify improvment.

In the Database, you will find data extracted from one of our [Github Project](https://github.com/waku-org/) and wake financial data. With those, create some indicators concerning:
 - The repartition of the issues.
 - The activity on different repos.
 - The Cost of the project.

The github data are base on the project [Waku](https://github.com/waku-org/).

The database configuration:
* host: `recruitment.free.technology`
* port: `5432`
* user: will be provided
* password: will be provided
* database name: `recuitment_task`
* schemas: `raw_github`,`raw_finance`

This repo contain a preconfigured partial stack to let you focus on the data manipulation. However, you are free to use any free technology you like, on the condition we can easily reproduce the result.


# Proof of Concept: Tracking Activity on Different Repositories

This Proof of Concept (PoC) is focused on tracking activity in GitHub repositories, covering metrics like issues, pull requests, and commits. The aim is to gather and organize this data, analyze trends, and create visualizations in Grafana for easy insights into repo activity.

we will get data based 
- Issues: Opened, closed, and active issues per repo.
- Pull Requests: Open and merged PRs.
- Commits: Number of commits per repo.

then model the data based on:
- Fact: `fact_repo_activity` which contains Aggregated repo activity data (issues, PRs, commits, etc.).

- Dimensions: `dim_repos`, `dim_users`, `dim_activity_types`. which will will contain metadata about the repositories, users, and activity types.

then aggregate and visualize the data based on:
- Repo -> Total number of issues, PRs, and commits.
- Time period -> Activity per day, week, or month.
- User -> Track user activity by number of issues assigned, PRs opened, etc.

dashboard will show repository activity:
Total Issues & PRs per Repo eg Bar charts to show the number of issues and PRs per repository.
Commits over Time eg Line charts to visualize commits per repo over time.
User Activity eg Pie charts for activity distribution across users (who is most active in terms of issues and PRs).

## Requirements

* Have docker installed

## Usage

* Deploy the container with `make run`
* Shutdown the containers with `make down`
* Build the dbt models with `make dbt-buidlt`
* Compile the dbt models with `make dbt-compile`

The data from the database and grafana are persisted with docker volumes.
