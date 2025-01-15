package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.BozhuEntity;
import com.entity.view.BozhuView;
import com.entity.vo.BozhuVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;



public interface BozhuService extends IService<BozhuEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<BozhuVO> selectListVO(Wrapper<BozhuEntity> wrapper);
   	
   	BozhuVO selectVO(@Param("ew") Wrapper<BozhuEntity> wrapper);
   	
   	List<BozhuView> selectListView(Wrapper<BozhuEntity> wrapper);
   	
   	BozhuView selectView(@Param("ew") Wrapper<BozhuEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<BozhuEntity> wrapper);
   	
}

