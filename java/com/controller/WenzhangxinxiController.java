package com.controller;

import com.annotation.IgnoreAuth;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.entity.WenzhangxinxiEntity;
import com.entity.view.WenzhangxinxiView;
import com.service.WenzhangxinxiService;
import com.utils.MPUtil;
import com.utils.PageUtils;
import com.utils.R;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;



@RestController
@RequestMapping("/wenzhangxinxi")
public class WenzhangxinxiController {
    @Autowired
    private WenzhangxinxiService wenzhangxinxiService;
    


    /**
     * 后端列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,WenzhangxinxiEntity wenzhangxinxi,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("bozhu")) {
			wenzhangxinxi.setBozhuzhanghao((String)request.getSession().getAttribute("username"));
		}
        EntityWrapper<WenzhangxinxiEntity> ew = new EntityWrapper<WenzhangxinxiEntity>();
		PageUtils page = wenzhangxinxiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, wenzhangxinxi), params), params));

        return R.ok().put("data", page);
    }
    
    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,WenzhangxinxiEntity wenzhangxinxi, HttpServletRequest request){
        EntityWrapper<WenzhangxinxiEntity> ew = new EntityWrapper<WenzhangxinxiEntity>();
		PageUtils page = wenzhangxinxiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, wenzhangxinxi), params), params));
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( WenzhangxinxiEntity wenzhangxinxi){
       	EntityWrapper<WenzhangxinxiEntity> ew = new EntityWrapper<WenzhangxinxiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( wenzhangxinxi, "wenzhangxinxi")); 
        return R.ok().put("data", wenzhangxinxiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(WenzhangxinxiEntity wenzhangxinxi){
        EntityWrapper< WenzhangxinxiEntity> ew = new EntityWrapper< WenzhangxinxiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( wenzhangxinxi, "wenzhangxinxi")); 
		WenzhangxinxiView wenzhangxinxiView =  wenzhangxinxiService.selectView(ew);
		return R.ok("查询文章信息成功").put("data", wenzhangxinxiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        WenzhangxinxiEntity wenzhangxinxi = wenzhangxinxiService.selectById(id);
		wenzhangxinxi.setClicknum(wenzhangxinxi.getClicknum()+1);
		wenzhangxinxi.setClicktime(new Date());
		wenzhangxinxiService.updateById(wenzhangxinxi);
        return R.ok().put("data", wenzhangxinxi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        WenzhangxinxiEntity wenzhangxinxi = wenzhangxinxiService.selectById(id);
		wenzhangxinxi.setClicknum(wenzhangxinxi.getClicknum()+1);
		wenzhangxinxi.setClicktime(new Date());
		wenzhangxinxiService.updateById(wenzhangxinxi);
        return R.ok().put("data", wenzhangxinxi);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody WenzhangxinxiEntity wenzhangxinxi, HttpServletRequest request){
    	wenzhangxinxi.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(wenzhangxinxi);
        wenzhangxinxiService.insert(wenzhangxinxi);
        return R.ok();
    }
    
    /**
     * 前端保存
     */
    @RequestMapping("/add")
    public R add(@RequestBody WenzhangxinxiEntity wenzhangxinxi, HttpServletRequest request){
    	wenzhangxinxi.setId(new Date().getTime()+new Double(Math.floor(Math.random()*1000)).longValue());
    	//ValidatorUtils.validateEntity(wenzhangxinxi);
        wenzhangxinxiService.insert(wenzhangxinxi);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody WenzhangxinxiEntity wenzhangxinxi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(wenzhangxinxi);
        wenzhangxinxiService.updateById(wenzhangxinxi);//全部更新
        return R.ok();
    }
    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
        wenzhangxinxiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    
    /**
     * 提醒接口
     */
	@RequestMapping("/remind/{columnName}/{type}")
	public R remindCount(@PathVariable("columnName") String columnName, HttpServletRequest request, 
						 @PathVariable("type") String type,@RequestParam Map<String, Object> map) {
		map.put("column", columnName);
		map.put("type", type);
		
		if(type.equals("2")) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar c = Calendar.getInstance();
			Date remindStartDate = null;
			Date remindEndDate = null;
			if(map.get("remindstart")!=null) {
				Integer remindStart = Integer.parseInt(map.get("remindstart").toString());
				c.setTime(new Date()); 
				c.add(Calendar.DAY_OF_MONTH,remindStart);
				remindStartDate = c.getTime();
				map.put("remindstart", sdf.format(remindStartDate));
			}
			if(map.get("remindend")!=null) {
				Integer remindEnd = Integer.parseInt(map.get("remindend").toString());
				c.setTime(new Date());
				c.add(Calendar.DAY_OF_MONTH,remindEnd);
				remindEndDate = c.getTime();
				map.put("remindend", sdf.format(remindEndDate));
			}
		}
		
		Wrapper<WenzhangxinxiEntity> wrapper = new EntityWrapper<WenzhangxinxiEntity>();
		if(map.get("remindstart")!=null) {
			wrapper.ge(columnName, map.get("remindstart"));
		}
		if(map.get("remindend")!=null) {
			wrapper.le(columnName, map.get("remindend"));
		}

		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("bozhu")) {
			wrapper.eq("bozhuzhanghao", (String)request.getSession().getAttribute("username"));
		}

		int count = wenzhangxinxiService.selectCount(wrapper);
		return R.ok().put("count", count);
	}
	
	/**
     * 前端智能排序
     */
	@IgnoreAuth
    @RequestMapping("/autoSort")
    public R autoSort(@RequestParam Map<String, Object> params,WenzhangxinxiEntity wenzhangxinxi, HttpServletRequest request,String pre){
        EntityWrapper<WenzhangxinxiEntity> ew = new EntityWrapper<WenzhangxinxiEntity>();
        Map<String, Object> newMap = new HashMap<String, Object>();
        Map<String, Object> param = new HashMap<String, Object>();
		Iterator<Map.Entry<String, Object>> it = param.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String key = entry.getKey();
			String newKey = entry.getKey();
			if (pre.endsWith(".")) {
				newMap.put(pre + newKey, entry.getValue());
			} else if (StringUtils.isEmpty(pre)) {
				newMap.put(newKey, entry.getValue());
			} else {
				newMap.put(pre + "." + newKey, entry.getValue());
			}
		}
		params.put("sort", "clicknum");
        params.put("order", "desc");
		PageUtils page = wenzhangxinxiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, wenzhangxinxi), params), params));
        return R.ok().put("data", page);
    }


}
