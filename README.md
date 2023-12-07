# Cube in a Box

The Cube in a Box is a simple way to run the [Open Data Cube](https://www.opendatacube.org).

## How to use:

### 1. Setup:

**Checkout the Repo:**
> `git clone https://github.com/digitalearthafrica/cube-in-a-box.git` or `git clone git@github.com:digitalearthafrica/cube-in-a-box.git`

**First time users of Docker should run:**
* `bash setup.sh` - This will get your system running and install everything you need.
* Note that after this step you will either need to logout/login, or run the next step with `sudo`

**If you already have `make` , `docker` and `docker compose` installed. For a custom bounding box append `BBOX=<left>,<bottom>,<right>,<top>` to the end of the command.**
* `make setup` or `make setup-prod` (for speed)
* Custom bounding box: `make setup BBOX=-2,37,15,47` or `make setup-prod BBOX=-2,37,15,47`

**If you do not have `make` installed and would rather run the commands individually run the following:**

* Build a local environment: `docker compose build`
* Start a local environment: `docker compose up`
* Set up your local postgres database (after the above has finished) using:
  * `docker compose exec jupyter datacube -v system init`
  * `docker compose exec jupyter dc-sync-products https://raw.githubusercontent.com/digitalearthafrica/config/master/prod/products_prod.csv`
* Index a default region with sentinel data:
  * `docker compose exec jupyter stac-to-dc --catalog-href=https://explorer.digitalearth.africa/stac/ --collections=s2_l2a --bbox=25,20,35,30 --limit=10`
* Shutdown your local environment:
  * `docker compose down`

### 2. Usage:
View the Jupyter notebook `Sentinel_2.ipynb` at [http://localhost](http://localhost) using the password `secretpassword`. Note that you can index additional areas using the `Indexing_More_Data.ipynb` notebook.

## Deploying to AWS

To deploy to AWS, you can either do it on the command line, with the AWS command line installed or the magic URL below and the AWS console. Detailed instructions are [available](docs/Detailed_Install.md).

Once deployed, if you navigate to the IP of the deployed instance, you can access Jupyter with the password you set in the parameters.json file or in the AWS UI if you used the magic URL.

### Magic link

[Launch a Cube in a Box](https://console.aws.amazon.com/cloudformation/home?#/stacks/new?stackName=cube-in-a-box&templateURL=https://deafrica-dev-cfn.s3.af-south-1.amazonaws.com/cube-in-a-box/cube-in-a-box-cloudformation.yml)

You will need to have an SSH key setup in the region first:

* [eu-west-1](https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#KeyPairs:)
* [us-west-2](https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#KeyPairs:)
* [ap-southeast-2](https://ap-southeast-2.console.aws.amazon.com/ec2/v2/home?region=ap-southeast-2#KeyPairs:)

You need to be logged in to the AWS Console deploy using this URL. Once logged in, click the link, and follow the prompts including settings a bounding box region of interest, EC2 instance type and password for Jupyter.

### Command line

* Alter the parameters in the [parameters.json](./parameters.json) file
* Run `make create-infra`
* If you want to change the stack, you can do `make update-infra` (although it may be cleaner to delete and re-create the stack)
