<?php

use Alfred\Workflows\Workflow;

require __DIR__ . '/vendor/autoload.php';

if (empty($argv[1]) || !($sites = json_decode($argv[1]))) {
  print 'Arguments are required.';
  exit(1);
}

$workflow = new Workflow();

foreach ($sites as $uuid => $site) {
  $result = $workflow->result();
  $site_url = 'https://dashboard.pantheon.io/sites/' . $uuid;

  $result->uid($uuid)
    ->title($site->name)
    ->subtitle($site->framework)
    ->quicklookurl($site_url)
    ->arg($uuid);
}

echo $workflow->output();