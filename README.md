# About this Repo

This is a fork of Git repo of the Docker official image for [teamspeak](https://registry.hub.docker.com/_/teamspeak/).

# Supported tags and respective `Dockerfile`

-	[`3.3`, `3.3.0`, `latest` (*3.3/Dockerfile*)]

# Quick reference

-	**Where to get help**:  
	[the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](https://blog.docker.com/2016/11/introducing-docker-community-directory-docker-community-slack/), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

-	**Where to file issues**:  
	[https://github.com/Pe46dro/teamspeak3-linux-docker-images/issues](https://github.com/Pe46dro/teamspeak3-linux-docker-images/issues)

-	**Supported architectures**: `amd64`

-	**Supported Docker versions**:  
	[the latest release](https://github.com/docker/docker-ce/releases/latest) (down to 1.6 on a best-effort basis)

# How to use this image

To start a TeamSpeak server, accept the license agreement, and map the ports to the host:

```console
$ docker run -p 9987:9987/udp -p 10011:10011 -p 30033:30033 -e TS3SERVER_LICENSE=accept teamspeak
```

Then you can connect to `your-docker-host-ip` in your TeamSpeak client.
Please write down the server query password, and server admin privilege key that were generated (you can find it on container logs). These are needed to administrate the TeamSpeak server.

## Container shell access

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a shell inside your `teamspeak` container:

```console
$ docker exec -it some-teamspeak sh
```

The TeamSpeak server log is available through Docker's container log:

```console
$ docker logs some-teamspeak
```

## Environment Variables

When you start the `teamspeak` image, you can adjust the configuration of the TeamSpeak server instance by passing one or more environment variables on the `docker run` command line.

### `HEALTCHECK_MONITOR_PORT`

Sets the voice port where healthcheck will be performed

### `TS3SERVER_LICENSEPATH`

Sets the path where the TeamSpeak server is looking for the `licensekey.dat`. This variable is the path to the directory where the `licensekey.dat` is supposed to be located. Defaults to /var/ts3server/.

### `TS3SERVER_FILETRANSFERPORT`

This variable controls the TCP Port opened for file transfers. Defaults to 30033.

### `TS3SERVER_QUERYPORT`

This variable controls the TCP Port opened for ServerQuery connections. Defaults to 10011.

### `TS3SERVER_QUERYSSHPORT`

This variable controls the TCP Port opened for ServerQuery connections using SSH. Defaults to 10022.

### `TS3SERVER_DB_PLUGIN`

This variable controls what kind of database the TeamSpeak server is using.

### `TS3SERVER_DB_PLUGINPARAMETER`

The content of the this variable is send as `parameter` to the db plugin.

### `TS3SERVER_DB_SQLPATH`

This variable controls where the TeamSpeak server looks for sql files. Defaults to /opt/ts3server/sql/.

### `TS3SERVER_DB_SQLCREATEPATH`

This variable is the path to the sql scripts used to initialize the database. The path is relative to `TS3SERVER_DB_SQLPATH`

### `TS3SERVER_DB_CONNECTIONS`

This variable controls how many concurrent connections to the database are being used. Must be at least 2 and at most 100. Defaults to 10.

### `TS3SERVER_DB_CLIENTKEEPDAYS`

This variable is the amount of days that the TeamSpeak server will keep unused user identities. Users that have been added to a group will not be pruned, but guests will be.

### `TS3SERVER_IP_WHITELIST`

This variable controls where the whitelist is found. The file contains a list of IP addresses which are exempt from the flood protection system. Warning: Do not add any IP addresses that you don't trust, as it will allow them to flood the server.

### `TS3SERVER_IP_BLACKLIST`

This variable controls where the blacklist is found. The file contains a list of IP addresses that, no matter what, can't connect to the server query interface, even after a server restart.

### `TS3SERVER_LOG_PATH`

This variable controls the folder where the server stores its log files. Defaults to /var/ts3server/logs/.

### `TS3SERVER_LOG_QUERY_COMMANDS`

If this variable is set to 1, every query command that is sent to the server will be logged.<br><br>**Warning:** While this can help if you are running into issues with your server, it should be noted that this can cause your log files to become extremely large. Unless you absolutely want all commands to be logged, we recommend this variable to be set to 0 most of the time.

### `TS3SERVER_LOG_APPEND`

If this variable is set to 1, all new log entries are written into a single file per virtual server. We suggest setting this variable to 0 as it will make life easier when looking at the logs.

### `TS3SERVER_QUERY_PROTOCOLS`

Comma separated list of protocols that can be used to connect to the ServerQuery. Possible values are `raw` and `ssh`. If `raw` is specified a raw or "classic" ServerQuery is opened on `10011/tcp`. If `ssh` is specified an encrypted ServerQuery using SSH is opened at `10022/tcp`. Any combination of the aforementioned values can be specified in this parameter, including leaving it empty, which would disable ServerQuery altogether.

### `TS3SERVER_QUERY_TIMEOUT`

Number of seconds before a query connection is disconnected because of inactivity. If value is set to be zero or negative, the timeout will be disabled. The default is a timeout of 300 seconds.

### `TS3SERVER_QUERY_SSH_RSA_HOST_KEY`

Path to the `ssh_host_rsa_key` to be used by query. If it does not exist, it will be created when the server is starting up.

## Where to Store Data

1.	Create a data directory on a suitable volume on your host system, e.g. `/my/own/datadir`.
2.	Start your `teamspeak` container like this:

```console
$ docker run --name some-teamspeak -v /my/own/datadir:/var/ts3server/ -d teamspeak:tag
```

The `-v /my/own/datadir:/var/ts3server/` part of the command mounts the `/my/own/datadir` directory from the underlying host system as `/var/ts3server` inside the container, where TeamSpeak by default will write its data files.

Note that users on host systems with SELinux enabled may see issues with this. The current workaround is to assign the relevant SELinux policy type to the new data directory so that the container will be allowed to access it:

```console
$ chcon -Rt svirt_sandbox_file_t /my/own/datadir
```

# Healt check

The HEALTHCHECK instruction in Dockerfile perform a check every 30s, 5 minutes after the container start, if the test fail 3 times in a row the container will be marked unhealthy.
To auto-restart unhealthy container you can use [willfarrell/autoheal](https://hub.docker.com/r/willfarrell/autoheal/)


# Mantainer
| [<img src="https://www.gravatar.com/avatar/35923b3b04e23bef801553656b606bfag?s=100" alt="" height="100">](https://github.com/Pe46dro) |
|--|
| [Pe46dro](https://github.com/Pe46dro) |

# License

View [license information](LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Some additional license information which was able to be auto-detected might be found in [the `repo-info` repository's `teamspeak/` directory](https://github.com/docker-library/repo-info/tree/master/repos/teamspeak).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.