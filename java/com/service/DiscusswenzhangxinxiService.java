package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.DiscusswenzhangxinxiEntity;
import com.entity.view.DiscusswenzhangxinxiView;
import com.entity.vo.DiscusswenzhangxinxiVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;



public interface DiscusswenzhangxinxiService extends IService<DiscusswenzhangxinxiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DiscusswenzhangxinxiVO> selectListVO(Wrapper<DiscusswenzhangxinxiEntity> wrapper);
   	
   	DiscusswenzhangxinxiVO selectVO(@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);
   	
   	List<DiscusswenzhangxinxiView> selectListView(Wrapper<DiscusswenzhangxinxiEntity> wrapper);
   	
   	DiscusswenzhangxinxiView selectView(@Param("ew") Wrapper<DiscusswenzhangxinxiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DiscusswenzhangxinxiEntity> wrapper);
   	
}

