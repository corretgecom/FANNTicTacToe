ANN Tic Tac Toe in a Symfony Console App
========================================

Project for *ANN Tic Tac Toe in a Symfony Console App* SymfonyCon Madrid 2014

## How to install

clone the repository an run 

```shell
cd srv/vagrant
vagrant up
```

## Usage

```shell
cd srv/vagrant
vagrant ssh
cd corretgecom
php bin/console
```

## Logs and files

The application will create some files in `/tmp` folder.

### Log files

- `human_vs_machine.log`
- `fann_player.log`

### Training files

- `training_*.dat`

### Artificial Neural Network file

- `ann.net`