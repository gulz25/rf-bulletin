# RF Bulletin Board

## purpose

- for enhancement of the communications in RF dance community.

## notes

- `json` file of service account is not under management of git for security reasons, thus prepare one as necessary

* bulletin board to be used is yet to be selected.

## architecture

![architecture](https://user-images.githubusercontent.com/29003909/108156650-64de8c80-7124-11eb-80af-799fd26e744d.png)

## description

- wordpress software deployed on GCE instance on GCP.
- wordpress
  - URL
    - for users:  http://34.84.39.221
                  http://rfcommunity.page
    - for admin:  http://34.84.39.221/wp-login.php
                  http://rfcommunity.page/wp-login.php
## preparation

- authenticate and login to the google account

```bash
gcloud auth application-default login
```

- create service account use for terraform.

```bash
gcloud iam service-accounts create mae-terraform-sa
```

- provide necessary permissions to the service account created.

```bash
gcloud projects add-iam-policy-binding rf-bulletin --member serviceAccount:mae-terraform-sa@rf-bulletin.iam.gserviceaccount.com --role roles/editor
```

- issue the service account key.

```bash
gcloud iam service-accounts keys create credential/account.json --iam-account mae-terraform-sa@rf-bulletin.iam.gserviceaccount.com
```

- register the json file as the environmental variable.

```bash
export GOOGLE_CLOUD_KEYFILE_JSON=<path-to-terraform-project>/credential/account.json
```

## gcloud commands used aside from terraform - attaching static IP address to the web server

- generate ssh key and register as the ssh key in metadata
  - you may configure `~/.ssh/config` to enable ssh proxy to web server via bastion server (rf-jumphost)

```bash
gcloud compute ssh rf-jumphost
```

## plugins
- bbPress
- BuddyPress
- GD bbPress Attachments
- Really Simple SSL
- SSL Zen
## reference

- installation, docker
https://docs.docker.com/engine/install/linux-postinstall/

- wordpress
https://web-kanji.com/posts/wordpress-bulletin-board
https://41y.me/free-theme-for-buddypress/
https://blog-bootcamp.jp/start/wordpress-bbpress/

- dns, custom domains
https://ymym3412.hatenablog.com/entry/2019/12/22/170811
https://qiita.com/HeRo/items/f9eb8d8a08d4d5b63ee9
