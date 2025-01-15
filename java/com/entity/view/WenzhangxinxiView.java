package com.entity.view;

import com.entity.WenzhangxinxiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
 


@TableName("wenzhangxinxi")
public class WenzhangxinxiView  extends WenzhangxinxiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public WenzhangxinxiView(){
	}
 
 	public WenzhangxinxiView(WenzhangxinxiEntity wenzhangxinxiEntity){
 	try {
			BeanUtils.copyProperties(this, wenzhangxinxiEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}
}
