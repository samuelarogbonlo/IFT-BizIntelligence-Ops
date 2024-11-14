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


# solution
This dbt project includes models for key performance indicators related to GitHub repository data. It covers:

- Repartition of Issues: Provides insights on the distribution of issues across categories and assignees.
- Project Cost: Tracks financial metrics, aggregating costs at various levels.
- Repo Activity (POC): Proof of concept model that tracks activity across different repositories.

Dashboards for these indicators are included in the `dbt_project/dashboards` directory, enabling visualization of the key metrics.

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
- Total Issues & PRs per Repo eg Bar charts to show the number of issues and PRs per repository.
- Commits over Time eg Line charts to visualize commits per repo over time.
- User Activity eg Pie charts for activity distribution across users (who is most active in terms of issues and PRs).

## Requirements

* Have docker installed

## Usage

* Deploy the containers with `make up` to spin up the postgres, grafana and dbt services

* Retrieve schema and tables from the remote PostgreSQL database. Use the credentials provided below to connect. You can then export the data from the remote database to the local database within the Docker container, either by using a migration tool like Fivetran/Airbyte or manually with a database tool like DBeaver.
 
The database configuration:

    Remote:
        * host: `recruitment.free.technology`
        * port: `5432`
        * user: ******
        * password: ******
        * database name: `recuitment_task`
        * schemas: `raw_github`,`raw_finance`
    
    local:
        * host: `database`
        * port: `5432`
        * user: `admin`
        * password: `Password`
        * database name: `postgres`

* Compile the dbt models with `make dbt-compile` to debugg and verify the SQL structure

* Build the dbt models with `make dbt-build`

* Login to the grafana with `http://localhost:3001` and credentials `admin` and `Password!`

* Import grafana dashboard from the dashboard json files in the `dbt_project/dashboards` folder

* Shutdown the containers with `make down`