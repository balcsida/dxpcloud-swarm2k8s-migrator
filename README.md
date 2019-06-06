# dxpcloud-swarm2k8s-migrator

Migration helper for DXP Cloud

## Usage

1. Download [the example LCP.json](LCP.json) to an empty folder and configure it according your needs (see Configuration for more info)
2. Deploy it using `lcp` on the production environment. Example: `lcp deploy -p <projectname> -e prd -s swarm2k8s
3. See the logs for the deployed service.

## Configuration

### `SWARM_PROJECT_NAME`

The name of the project you would like to migrate

### `SWARM_BACKUP_ID`

The ID of the backup you would like to migrate. You can find it under Name in the Backups menu

### `SWARM_PROJECT_MASTER_TOKEN`

The master token of your project. You can find it under Settings.

### `LCP_USER_ID`

You need to set your user ID, which you can obtain by logging in to [liferay.cloud](https://liferay.cloud/), then visit this url:
https://api.liferay.cloud/user

Your user id will start with `00` (double zero) look like this: `00ulvkodwC1DoypUP356`
