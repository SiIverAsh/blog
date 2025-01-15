package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.JubaotousuEntity;
import com.entity.view.JubaotousuView;
import com.entity.vo.JubaotousuVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;



public interface JubaotousuService extends IService<JubaotousuEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<JubaotousuVO> selectListVO(Wrapper<JubaotousuEntity> wrapper);
   	
   	JubaotousuVO selectVO(@Param("ew") Wrapper<JubaotousuEntity> wrapper);
   	
   	List<JubaotousuView> selectListView(Wrapper<JubaotousuEntity> wrapper);
   	
   	JubaotousuView selectView(@Param("ew") Wrapper<JubaotousuEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<JubaotousuEntity> wrapper);
   	
}

