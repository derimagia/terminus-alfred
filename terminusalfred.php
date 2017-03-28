<?php

use Alfred\Workflows\Workflow;

require __DIR__ . '/vendor/autoload.php';

if (empty($argv[1])) {
  print 'Arguments are required.';
  exit(1);
}

$sites = json_decode($argv[1]);

if (empty($sites)) {
  print 'Arguments are invalid.';
  exit(1);
}

$workflow = new Workflow();

foreach ($sites as $uuid => $site) {
  $workflow->result()
    ->uid($uuid)
    ->title($site->name)
    ->subtitle($site->framework)
    ->arg($site->id);
}

echo $workflow->output();