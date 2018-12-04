package com.platform.api;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.platform.annotation.IgnoreAuth;
import com.platform.entity.FullUserInfo;
import com.platform.entity.UserInfo;
import com.platform.entity.UserVo;
import com.platform.service.ApiUserService;
import com.platform.service.TokenService;
import com.platform.util.AesCbcUtil;
import com.platform.util.ApiBaseAction;
import com.platform.util.ApiUserUtils;
import com.platform.util.CommonUtil;
import com.platform.utils.R;
import com.platform.validator.Assert;
import com.qiniu.util.StringUtils;
import com.vdurmont.emoji.EmojiParser;

/**
 * API登录授权
 *
 * @author lipengjun
 * @email 939961241@qq.com
 * @date 2017-03-23 15:31
 */
@RestController
@RequestMapping("/api/auth")
public class ApiAuthController extends ApiBaseAction {
    private Logger logger = Logger.getLogger(getClass());
    @Autowired
    private ApiUserService userService;
    @Autowired
    private TokenService tokenService;

    /**
     * 登录
     */
    @IgnoreAuth
    @RequestMapping("login")
    public R login(String mobile, String password) {
        Assert.isBlank(mobile, "手机号不能为空");
        Assert.isBlank(password, "密码不能为空");

        //用户登录
        long userId = userService.login(mobile, password);

        //生成token
        Map<String, Object> map = tokenService.createToken(userId);

        return R.ok(map);
    }

    /**
	 * 登录
	@IgnoreAuth
	@RequestMapping("login_by_weixin")
	public Object loginByWeixin() {
	    JSONObject jsonParam = this.getJsonRequest();
	    FullUserInfo fullUserInfo = null;
	    String code = "";
	    if (!StringUtils.isNullOrEmpty(jsonParam.getString("code"))) {
	        code = jsonParam.getString("code");
	    }
	    if (null != jsonParam.get("userInfo")) {
	        fullUserInfo = jsonParam.getObject("userInfo", FullUserInfo.class);
			logger.info("fullUserInfo：" + JSONObject.toJSONString(fullUserInfo));
	    }
	
	    Map<String, Object> resultObj = new HashMap();
	    //
	    UserInfo userInfo = fullUserInfo.getUserInfo();
	
	    //获取openid
	    String requestUrl = ApiUserUtils.getWebAccess(code);//通过自定义工具类组合出小程序需要的登录凭证 code
	    logger.info("》》》组合token为：" + requestUrl);
	    JSONObject sessionData = CommonUtil.httpsRequest(requestUrl, "GET", null);
		logger.info("sessionData：" + JSONObject.toJSONString(sessionData));
	
	    if (null == sessionData || StringUtils.isNullOrEmpty(sessionData.getString("openid"))) {
	        return toResponsFail("登录失败");
	    }
	    //验证用户信息完整性
	    String sha1 = CommonUtil.getSha1(fullUserInfo.getRawData() + sessionData.getString("session_key"));
	    if (!fullUserInfo.getSignature().equals(sha1)) {
	        return toResponsFail("登录失败");
	    }
	    Date nowTime = new Date();
	    UserVo userVo = userService.queryByOpenId(sessionData.getString("openid"));
	    if (null == userVo) {
	        userVo = new UserVo();
			userVo.setUsername(CharUtil.getRandomString(12) + "@wx");
	        userVo.setPassword(sessionData.getString("openid"));
	        userVo.setRegister_time(nowTime);
	        userVo.setRegister_ip(this.getClientIp());
	        userVo.setLast_login_ip(userVo.getRegister_ip());
	        userVo.setLast_login_time(userVo.getRegister_time());
	        userVo.setWeixin_openid(sessionData.getString("openid"));
	        userVo.setAvatar(userInfo.getAvatarUrl());
	        userVo.setGender(userInfo.getGender()); // //性别 0：未知、1：男、2：女
	        userVo.setNickname(userInfo.getNickName());
	        userService.save(userVo);
	    } else {
	        userVo.setLast_login_ip(this.getClientIp());
	        userVo.setLast_login_time(nowTime);
	        userService.update(userVo);
	    }
	
	    Map<String, Object> tokenMap = tokenService.createToken(userVo.getUserId());
	    String token = MapUtils.getString(tokenMap, "token");
	
	    if (null == userInfo || StringUtils.isNullOrEmpty(token)) {
	        return toResponsFail("登录失败");
	    }
	
	    resultObj.put("token", token);
	    resultObj.put("userInfo", userInfo);
	    resultObj.put("userId", userVo.getUserId());
	    return toResponsSuccess(resultObj);
	}
	 */

	/*
	@IgnoreAuth
	@RequestMapping("login_by_weixin_v0")
	public Object loginByWeixinNew(String encryptedData, String iv, String code) {
		//获取openid
		String requestUrl = ApiUserUtils.getWebAccess(code);//通过自定义工具类组合出小程序需要的登录凭证 code
		logger.info("》》》组合token为：" + requestUrl);
		JSONObject sessionData = CommonUtil.httpsRequest(requestUrl, "GET", null);
		if (null == sessionData) {
			return toResponsFail("登录失败");
		}
	
		// 获取会话密钥（session_key）  
		String session_key = sessionData.get("session_key").toString();
	
		// 用户的唯一标识（openid）  
		String openid = (String) sessionData.get("openid");
	
		JSONObject result = AesCbcUtil.decrypt(encryptedData, session_key, iv);
	
		Date nowTime = new Date();
		UserVo userVo = userService.queryByOpenId(openid);
		if (null == userVo) {
			userVo = new UserVo();
			userVo.setUsername("微信用户" + CharUtil.getRandomString(12));
			userVo.setPassword(openid);
			userVo.setRegister_time(nowTime);
			userVo.setRegister_ip(this.getClientIp());
			userVo.setLast_login_ip(userVo.getRegister_ip());
			userVo.setLast_login_time(userVo.getRegister_time());
			userVo.setWeixin_openid(openid);
			userVo.setAvatar((String) result.get("avatarUrl"));
			userVo.setGender(Integer.parseInt(String.valueOf(result.get("gender")).trim())); // //性别 0：未知、1：男、2：女
			userVo.setNickname((String) result.get("nickName"));
			userService.save(userVo);
		} else {
			userVo.setLast_login_ip(this.getClientIp());
			userVo.setLast_login_time(nowTime);
			userService.update(userVo);
		}
	
		Map<String, Object> tokenMap = tokenService.createToken(userVo.getUserId());
		String token = MapUtils.getString(tokenMap, "token");
	
		Map<String, Object> resultObj = new HashMap();
		resultObj.put("token", token);
		//		resultObj.put("userInfo", userInfo);
		resultObj.put("userId", userVo.getUserId());
		return toResponsSuccess(resultObj);
	
	}
	*/

	/**
	 * 微信登录
	 * 通过解密EncryptedData得到加密的信息
	 
	@IgnoreAuth
	@RequestMapping("login_by_weixin_v1")
	public Object loginByWeixinV1() {
		JSONObject jsonParam = this.getJsonRequest();
		FullUserInfo fullUserInfo = null;
		String code = "";
		if (!StringUtils.isNullOrEmpty(jsonParam.getString("code"))) {
			code = jsonParam.getString("code");
		}
		if (null != jsonParam.get("userInfo")) {
			fullUserInfo = jsonParam.getObject("userInfo", FullUserInfo.class);
			logger.info("fullUserInfo：" + JSONObject.toJSONString(fullUserInfo));
		}
	
		//获取openid
		String requestUrl = ApiUserUtils.getWebAccess(code);//通过自定义工具类组合出小程序需要的登录凭证 code
		logger.info("》》》组合token为：" + requestUrl);
		JSONObject sessionData = CommonUtil.httpsRequest(requestUrl, "GET", null);
		if (null == sessionData) {
			return toResponsFail("登录失败");
		}
	
		// 获取会话密钥（session_key）  
		String session_key = sessionData.get("session_key").toString();
	
		JSONObject result = AesCbcUtil.decrypt(fullUserInfo.getEncryptedData(), session_key, fullUserInfo.getIv());
		if (result == null) {
			return toResponsFail("登录失败");
		}
	
		String openid = (String) result.get("openid");
		String unionId = (String) result.get("unionId");
	
		Date nowTime = new Date();
		UserVo userVo = userService.queryByOpenId(unionId);
		if (null == userVo) {
			userVo = new UserVo();
			userVo.setUsername(CharUtil.getRandomString(12) + "@wx");
			userVo.setPassword(unionId);
			userVo.setRegister_time(nowTime);
			userVo.setRegister_ip(this.getClientIp());
			userVo.setLast_login_ip(userVo.getRegister_ip());
			userVo.setLast_login_time(userVo.getRegister_time());
			userVo.setWeixin_openid(openid);
			userVo.setWeixin_unionId(unionId);
			userVo.setAvatar((String) result.get("avatarUrl"));
			userVo.setGender(Integer.parseInt(String.valueOf(result.get("gender")).trim())); // //性别 0：未知、1：男、2：女
			userVo.setNickname((String) result.get("nickName"));
			userService.save(userVo);
		} else {
			userVo.setLast_login_ip(this.getClientIp());
			userVo.setLast_login_time(nowTime);
			userService.update(userVo);
		}
	
		Map<String, Object> tokenMap = tokenService.createToken(userVo.getUserId());
		String token = MapUtils.getString(tokenMap, "token");
	
		Map<String, Object> resultObj = new HashMap<>();
		resultObj.put("token", token);
		resultObj.put("userId", userVo.getUserId());
		return toResponsSuccess(resultObj);
	}
	*/

	/**
	 * 微信登录
	 * 先rawData 验签
	 * 通过解密EncryptedData得到加密的信息
	 */
	@IgnoreAuth
	@RequestMapping("login_by_weixin_v2")
	public Object loginByWeixinV2() {
		JSONObject jsonParam = this.getJsonRequest();
		FullUserInfo fullUserInfo = null;
		String code = "";
		if (!StringUtils.isNullOrEmpty(jsonParam.getString("code"))) {
			code = jsonParam.getString("code");
		}
		if (null != jsonParam.get("userInfo")) {
			fullUserInfo = jsonParam.getObject("userInfo", FullUserInfo.class);
			logger.info("fullUserInfo：" + JSONObject.toJSONString(fullUserInfo));
		}

		Map<String, Object> resultObj = new HashMap();
		UserInfo userInfo = fullUserInfo.getUserInfo();

		String requestUrl = ApiUserUtils.getWebAccess(code);//通过自定义工具类组合出小程序需要的登录凭证 code
		logger.info("》》》组合token为：" + requestUrl);
		JSONObject sessionData = CommonUtil.httpsRequest(requestUrl, "GET", null);
		logger.info("sessionData：" + JSONObject.toJSONString(sessionData));

		//验证用户信息完整性
		String sha1 = CommonUtil.getSha1(fullUserInfo.getRawData() + sessionData.getString("session_key"));
		if (!fullUserInfo.getSignature().equals(sha1)) {
			return toResponsFail("登录失败");
		}

		//解密数据
		JSONObject result = AesCbcUtil.decrypt(fullUserInfo.getEncryptedData(), sessionData.getString("session_key"),
				fullUserInfo.getIv());
		if (result == null) {
			return toResponsFail("登录失败");
		}

		String openid = (String) result.get("openId");
		String unionId = (String) result.get("unionId");

		Date nowTime = new Date();
		UserVo userVo = userService.queryByUnionId(unionId);
		if (null == userVo) {
			userVo = new UserVo();
			userVo.setUsername(unionId + "@wx");
			userVo.setPassword(unionId);
			userVo.setRegister_time(nowTime);
			userVo.setRegister_ip(this.getClientIp());
			userVo.setLast_login_ip(userVo.getRegister_ip());
			userVo.setLast_login_time(userVo.getRegister_time());
			userVo.setWeixin_openid(openid);
			userVo.setWeixin_unionId(unionId);
			userVo.setAvatar(userInfo.getAvatarUrl());
			userVo.setGender(userInfo.getGender()); // //性别 0：未知、1：男、2：女
			userVo.setNickname(EmojiParser.parseToAliases(userInfo.getNickName()));
			userService.save(userVo);
		} else {
			userVo.setLast_login_ip(this.getClientIp());
			userVo.setLast_login_time(nowTime);
			userService.update(userVo);
		}

		Map<String, Object> tokenMap = tokenService.createToken(userVo.getUserId());
		String token = MapUtils.getString(tokenMap, "token");

		if (null == userInfo || StringUtils.isNullOrEmpty(token)) {
			return toResponsFail("登录失败");
		}

		resultObj.put("token", token);
		resultObj.put("userInfo", userInfo);
		resultObj.put("userId", userVo.getUserId());
		return toResponsSuccess(resultObj);
	}
}
