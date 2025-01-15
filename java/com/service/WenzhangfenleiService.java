package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.entity.WenzhangfenleiEntity;
import com.entity.view.WenzhangfenleiView;
import com.entity.vo.WenzhangfenleiVO;
import com.utils.PageUtils;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;



public interface WenzhangfenleiService extends IService<WenzhangfenleiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<WenzhangfenleiVO> selectListVO(Wrapper<WenzhangfenleiEntity> wrapper);
   	
   	WenzhangfenleiVO selectVO(@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);
   	
   	List<WenzhangfenleiView> selectListView(Wrapper<WenzhangfenleiEntity> wrapper);
   	
   	WenzhangfenleiView selectView(@Param("ew") Wrapper<WenzhangfenleiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<WenzhangfenleiEntity> wrapper);
   	
}

