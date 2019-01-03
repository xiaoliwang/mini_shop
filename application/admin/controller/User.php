<?php
namespace app\admin\controller;
use app\admin\model\Admin;
use think\Controller;
use think\Db;
use think\Request;
use think\Session;
use think\View;
use app\admin\validate\Admin as AdminValidator;

class User extends Controller
{
    public function index(){
        //p(Session::get('username'));
        //return (new View)->fetch();
        new Common();
        return view();
    }


    //登陆
    public function login()
    {
        //--使用Db服务查询
        //必须跟上表前缀:table
        //$data = Db::table('gf_admin')->where('uid',1)->find();
        //设置了表前缀的话则可用name
        //$data = Db::name('admin')->where('uid',1)->find();

        //--使用助手函数查询
        //$data = db('admin')->where('uid',1)->find();

        //--使用模型查询
        //$data = AdminModel::get(1)->toArray();
        //p($data);

        if(IS_POST){
            $post = input('post.');
            //p($post);
            //用模型查询where时要find获取
            $dbData = (new Admin())->where('username',$post['username'])->find();
            //p($dbData['username']);
            //p($dbData->username);
            if($dbData){
                if(md5($post['password'])==$dbData['password']){
                    Session::set('username',$post['username']);
                    $this->success('登录成功',url('user/index'));
                }
                $this->error('密码错误');
            }
            $this->error('用户名不存在');
        }


        return view('');
    }

    //退出
    public function logout(){
        // 清除session（当前作用域）
        Session::clear();
        // 清除think作用域
        Session::clear('think');
        $this->success('退出成功',url('user/login'));
    }

    //修改密码
    public function changePassword(){
        new Common();//检测登录与否

        if(IS_POST){
            $post = input('post.');
            //p($post);
            //验证密码（旧、新、确认密码为空，及旧密码是否输入正确）
            $validate = \think\Loader::validate('Admin');
            if(!$validate->check($post)){//一次只出现一条错误信息
                Session::flash('changPwdError',$validate->getError());
            }else{
                //执行修改密码
                $user = (new Admin)->where('username',Session::get('username'))->find();
                $user->password = md5($post['password']);
                $user->save();
                // 清除session（当前作用域）
                session(null);
                $this->success('密码修改成功，请重新登录',url('login'));
            }
        }




        return view();

    }

}
