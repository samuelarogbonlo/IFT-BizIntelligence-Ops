# BI Operations Task

This repo provide a set of preconfigured tools that can be used for the recruitment task for IFT:

* PostgreSQL database
* DBT
* Grafana
* Docker
* DBeaver Software
* DBT-Utils. Get more details [here](https://docs.getdbt.com/docs/build/packages) and also be aware that many time because of version conflicts, python packkages clashes etc, I recommend you run the installation in a local virtual enviroment

## Tasks

One goal of the BI team is to design and implement dashboards to help Projects Lead have an overview of their project.
Those dashboards will be used for progress reporting, evaluating the project adoption, and identifying improvement.

In the Database, you will find data extracted from one of our [Github Project](https://github.com/waku-org/) and wake financial data. With those, create some indicators concerning:
 - The repartition of the issues.
 - The activity on different repos.
 - The Cost of the project.

The GitHub data are based on the project [Waku](https://github.com/waku-org/).


# Next Steps
This DBT project includes models for key performance indicators related to GitHub repository data. It covers:

- Repartition of Issues: Provides insights on the distribution of issues across categories and assignees.
- Project Cost: Tracks financial metrics, aggregating costs at various levels.
- Repo Activity (POC): Proof of concept model that tracks activity across different repositories.

The `dbt_project/dashboards` directory includes dashboards for these indicators, enabling visualization of the key metrics.

# Proof Of Concept: Tracking Activity On Different Repositories

This Proof of Concept (PoC) is focused on tracking activity in GitHub repositories, covering metrics like issues, pull requests, and commits. The aim is to gather and organize this data, analyze trends, and create visualizations in Grafana for easy insights into repo activity.

Materializations used:
- src data -> ephemeral (no persisting intermediate tables in the database)
- fact and dimension tables (to be referenced across multiple models or frequently accessed)

We will get data based on the following:
- Issues: Opened, closed, and active issues per repo.
- Pull Requests: Open and merged PRs.
- Commits: Number of commits per repo.

Then, model the data based on the following:
- Fact: `fact_repo_activity` contains aggregated repo activity data (issues, PRs, commits, etc.).
- Dimensions: `dim_repos`, `dim_users`, `dim_activity_types`. which will contain metadata about the repositories, users, and activity types.

Then, aggregate and visualize the data based on:
- Repo -> Total number of issues, PRs, and commits.
- Time period -> Activity per day, week, or month.
- User -> Track user activity by number of issues assigned, PRs opened, etc.

Then, the dashboard will show the repository activity:
- Total Issues & PRs per Repo, e.g., bar charts, are used to show the number of issues and PRs per repository.
- Commits over Time, e.g. Line charts to visualize commits per repo over time.
- User Activity, e.g. Pie charts for activity distribution across users (who is most active in terms of issues and PRs).

Finally, we can implement some data testing procedures as follows:
- Using built-in test capabilities in DBT for data validation, e.g unique check, not-null check, etc.
- implementing audit for columns for the metadata
- Setting up alerts for data anomalies by probably using a DBT test JSON file to log test results and then use a small Python service to trigger an alert if things go out of those results


## Usage

* Deploy the containers to spin up the Postgres, Grafana and DBT services
```
make up
```
* Open DBeaver to Retrieve schema and tables from the remote PostgreSQL database. Use the credentials provided below to connect by adding two new connections for Remote and local respectively. You can then export the data from the remote database to the local database within the Docker container, either by using a migration tool like Fivetran/Airbyte or manually with a database software called DBeaver.

The database configuration:

    Remote:
        * host: `recruitment.free.technology`
        * port: `5432`
        * user: ******
        * password: ******
        * database name: `recruitment_task`
        * schemas: `raw_github`,`raw_finance`

    local:
        * host: `localhost`
        * port: `5432`
        * user: `admin`
        * password: `Password`
        * database name: `postgres`

> **_NOTE_**
> - Under the local DB setup on dbeaver, in the Database/postgres/schemes directory, create `raw_github` and `raw_finance`. Due to the fact that the data is read-only, we will be copying the data manually from `remote` to `local`, and you can follow the instructions in the documentation [here](https://dbeaver.com/docs/dbeaver/Data-migration/). Also, we do not have write access to the DB, so we cannot explore DBT to automatically write models and create new tables on the remote DB.

* Compile the DBT models to debug and verify the SQL structure
```
make dbt-compile
```
* Build the dbt models
```
make dbt-build
```
* Login to the grafana with [here](http://localhost:3001) and credentials are below
```
Username: admin
Password: Password!
```
* Import grafana dashboards from the dashboard JSON files in the `grafana/dashboards` folder. The dashboards were moved to the current directory above for ease of access and central control of all Grafana files. With the dashboards, depending on the data that needs to be reviewed, you can define key data quality metrics and monitor these regularly.
* Shutdown the containers with `make down`

Based on the solution provided by integrating PostgreSQL, DBT, and Grafana, we've established a robust data pipeline for data extraction, transformation, and visualization.

> **_NOTE_**
> - The `dbt-utils` package was installed to set up the project for future scalability for good practices in data transformations and testing. While it is not directly used here, I believe its inclusion reflects an approach to ensure the project can easily incorporate advanced features and data quality checks in subsequent iterations in the future.

## Author
- Samuel Arogbonlo - [GitHub](https://github.com/samuelarogbonlo)

## License
The MIT License (http://www.opensource.org/licenses/mit-license.php)
