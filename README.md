Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### Matt notes on command line commands to get dbt up and running
# https://docs.getdbt.com/docs/quickstarts/dbt-core/manual-install

# create a directory for dbt projects and move into that directory
mkdir dbt
cd dbt

# install dbt-bigquery using python virtual environment 
# NB: to use dbt will always need to first activate the venv
sudo python3 -m venv dbt-venv
source dbt-venv/bin/activate
sudo -H pip install dbt-bigquery

# test installation, initiate project 'jaffle_shop' and move into the jaffle_shop folder
dbt --version
dbt init jaffle_shop
cd jaffle_shop
pwd

# test connection
# NB in first use will need to update application credentials to connect to bigquery
# gcloud auth application-default login
# https://cloud.google.com/sdk/gcloud/reference/auth/application-default
dbt debug

# run all models in the project
dbt run

# create a github repo in the current location (jaffle_shop folder), link to remote repo and push changes to the remote
git init
git branch -M main
git add .
git commit -m "Create a dbt project"
git remote add origin https://github.com/matt-salisbury/dbt-tutorial.git
git push -u origin main

# create a new branch to edit / add models
git checkout -b add-customers-model