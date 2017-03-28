<?php

use Pantheon\Terminus\Collections\Sites;

class AsyncSites {
  public $sites;

  function __construct() {
    $this->sites = new Sites();
  }
}                                              