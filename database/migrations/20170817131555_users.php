<?php

use think\migration\Migrator;
use think\migration\db\Column;

class Users extends Migrator
{
    /**
     * Change Method.
     *
     * Write your reversible migrations using this method.
     *
     * More information on writing migrations is available here:
     * http://docs.phinx.org/en/latest/migrations.html#the-abstractmigration-class
     *
     * The following commands can be used in this method and Phinx will
     * automatically reverse them when rolling back:
     *
     *    createTable
     *    renameTable
     *    addColumn
     *    renameColumn
     *    addIndex
     *    addForeignKey
     *
     * Remember to call "create()" or "update()" and NOT "save()" when working
     * with the Table class.
     */
    public function change() {
        // 前台用户表
        $table = $this->table( 'users' );
        $table->
            addColumn( 'username', 'string', array(
                'limit' => 15,
                'comment' => '前台用户名'
            ) )
            ->addColumn( 'password', 'string', array(
                'limit'   => 32,
                'comment' => '前台用户密码'
            ) )
            ->addColumn( 'address', 'string', array(
                'limit'   => 255,
                'default' => '',
                'comment' => '收货地址'
            ) )
            ->addIndex( array( 'username' ), array( 'unique' => true ) )
            ->create();
    }
}
