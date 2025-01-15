package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.WenzhangxinxiEntity;
import com.entity.view.WenzhangxinxiView;
import com.entity.vo.WenzhangxinxiVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;



public interface WenzhangxinxiService extends IService<WenzhangxinxiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<WenzhangxinxiVO> selectListVO(Wrapper<WenzhangxinxiEntity> wrapper);
   	
   	WenzhangxinxiVO selectVO(@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);
   	
   	List<WenzhangxinxiView> selectListView(Wrapper<WenzhangxinxiEntity> wrapper);
   	
   	WenzhangxinxiView selectView(@Param("ew") Wrapper<WenzhangxinxiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<WenzhangxinxiEntity> wrapper);
   	
}

