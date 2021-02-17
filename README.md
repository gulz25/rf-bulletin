# RF Bulletin Board

## purpose

- for enhancement of the communications in RF dance community.

## notes

- `json` file of service account is not under management of git for security reasons, thus prepare one as necessary

* bulletin board to be used is yet to be selected.

## architecture

![名称未設定ファイル](https://user-images.githubusercontent.com/29003909/107490570-657b9e00-6bcd-11eb-96e7-24d063893bc4.png)

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
