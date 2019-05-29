# dxpcloud-swarm2k8s-migrator

Migration helper for Liferay Cloud

Configure the following environment variables in `LCP.json`:

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

Your user id will start with `00` (double zer) look like this: `00ulvkodwC1DoypUP356`