package com.entity.view;

import com.entity.DiscusswenzhangxinxiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
 


@TableName("discusswenzhangxinxi")
public class DiscusswenzhangxinxiView  extends DiscusswenzhangxinxiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public DiscusswenzhangxinxiView(){
	}
 
 	public DiscusswenzhangxinxiView(DiscusswenzhangxinxiEntity discusswenzhangxinxiEntity){
 	try {
			BeanUtils.copyProperties(this, discusswenzhangxinxiEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}
}
