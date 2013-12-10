package org.spzktshow.moumoon.sunshine.controller.componentList
{
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.spzktshow.moumoon.core.component.enum.ComponentEnum;
	import org.spzktshow.moumoon.core.component.utils.ComponentControlUtils;
	import org.spzktshow.moumoon.core.componentTemplate.configData.ComponentPropertyEnum;
	import org.spzktshow.moumoon.core.componentTemplate.enum.ComponentTemplateEnum;
	import org.spzktshow.moumoon.core.componentValue.IComponentPropertyValue;
	import org.spzktshow.moumoon.core.source.ISource;
	import org.spzktshow.moumoon.sunshine.core.component.IListComponent;
	import org.spzktshow.moumoon.sunshine.core.component.utils.ListComponentFactory;
	import org.spzktshow.moumoon.sunshine.core.component.utils.ListComponentUtils;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory.ComponentDisplayFactory;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory.ComponentTemplateFactory;
	import org.spzktshow.moumoon.sunshine.core.editorComponentTemplate.factory.ComponentValueListFactory;
	import org.spzktshow.moumoon.sunshine.model.component.ComponentModel;
	import org.spzktshow.moumoon.sunshine.model.componentList.ComponentListModel;
	import org.spzktshow.moumoon.sunshine.model.file.FileModel;
	import org.spzktshow.moumoon.sunshine.model.source.SourceModel;
	
	public class ComponentListCommand extends SimpleCommand
	{
		/**
		 *初始化model 
		 */		
		public static const INIT:String = "componentListCommandInit";
		/**
		 *初始化model完成 >>
		 */		
		public static const INITED:String = "componentListCommandInited";
		/**
		 *添加顶级组件 ，相当于初始化的时候创建组件列表
		 */		
		public static const CREATE_COMPONENT:String = "componentListCommandAddComponent";
		/**
		 *添加顶级组件完成  >>
		 */		
		public static const CREATED_COMPONENT:String  = "componentListCommandAddedComponent";
		/**
		 *根据文件焦点的改变改变组件 
		 */		
		public static const CHANGE_COMPONENT:String = "componentListCommandChangeComponent";
		/**
		 *改变焦点组件完成  >>
		 */		
		public static const CHANGED_COMPONENT:String = "componentListCommandChangedComponent";
		/**
		 *向当前的焦点的childComponent添加子组件 
		 */		
		public static const ADD_CHILD:String = "componentListCommandAddChild";
		/**
		 *向焦点组件添加子组件完成  >>
		 */		
		public static const ADDED_CHILD:String = "componentListCommandAddedChild";
		/**
		 *组件操作刷新完成  >>
		 */		
		public static const REFRESHED:String = "componentListCommandRefreshed";
		/**************************************component operation*******************************************************///model层组件数据改变
		/***type***/
		/**
		 *移动组件 
		 */		
		public static const TYPE_MOVE:String = "componentListCommandTypeMove";
		/*********************component****************/
		/**
		 *组件操作
		 */		
		public static const COMPONENT_OPERATION:String = "componentListCommandComponentOperation";
		/**
		 *组件操作更新  >>
		 * 当组建有属性更新时发送
		 */		
		public static const COMPONENT_OPERATION_REFRESHED:String = "componentListCommandComponentOperationRefreshed";
		/*********************focus********************/
		/**
		 *焦点组件操作 
		 */		
		public static const FOCUS_OEPRATION:String = "componentListCommandFocusComponentOperation";
		/**
		 * 焦点操作更新 >>
		 * 当焦点组建有属性更新时发送
		 * */
		public static const FOCUS_OPREATION_REFRESHED:String = "componentListCommandFocuseOperationRefreshed";
		/***************/
		/****************************************displaylayer operation**************************************************///显示层组件数据改变,不会影响model层实际显示列表数据的改变
		/**
		 *显示层属性变化 发送 >> 
		 */		
		public static const DISPLAY_LAYER_OPERATION_REFRESHED:String = "componentListCommandDisplayLayerOperationRefreshed";
		/**
		 *显示某个组件 
		 */		
		public static const DISPLAY_LAYER_OPERATION:String = "componentListCommandDisplayLayerOperation";
		/**
		 *type 显示或隐藏某个组件 
		 */		
		public static const TYPE_DISPLAY_LAYER_OPERATION_VISIBLE:String = "componentListCommandDisplayLayerOperationTypeVisible";
		/**
		 *type 焦点组件 
		 */		
		public static const TYPE_DISPLAY_LAYER_OPERATION_FOCUS:String = "componentListCommandDisplayLayerOperationTypeFocus";
		/**
		 *type 是否打开 
		 */		
		public static const TYPE_DISPLAY_LAYER_OEPRATION_ISOPEN:String = "componentListCommandDisplayLayerOperationTypeIsopen";
		/*****************/
		public function ComponentListCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			if (notification.getName() == INIT)
			{
				var componentListModel:ComponentListModel = new ComponentListModel;
				facade.registerProxy(componentListModel);
			}
			else if (notification.getName() == CREATE_COMPONENT)//创建组件列表
			{
				var fileModel:FileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				//create name
				var name:String = fileModel.editorFileOperation.createComponentDefaultName();
				//create component
				var component:IListComponent = ListComponentFactory.createComponent(name);
				component.type = ComponentEnum.Entirety;
				component.componentTemplate = ComponentTemplateFactory.create(ComponentTemplateEnum.CONTAINER);
				ComponentValueListFactory.filter(component);//直接默认default
				//create displayObject
				component.entity = ComponentDisplayFactory.createComponent(component);
				//create editorFile
				var rComponentListCommandData:ComponentListCommandData = notification.getBody() as ComponentListCommandData;
				componentListModel.editorFile = rComponentListCommandData.editorFile;
				//将创建的组件装配到编辑文件的数据结构中
				componentListModel.editorFile.component = component;
				componentListModel.editorFile.componentGroup.addItem(component);
				//创建完成
				var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
				sComponentListCommandData.editorFile = componentListModel.editorFile;
				this.sendNotification(ComponentListCommand.CREATED_COMPONENT, sComponentListCommandData);
				focusComponent(componentListModel.editorFile.component, componentListModel, rComponentListCommandData);
			}
			else if (notification.getName() == CHANGE_COMPONENT)
			{
				rComponentListCommandData = notification.getBody() as ComponentListCommandData;
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				componentListModel.editorFile = rComponentListCommandData.editorFile;
				sComponentListCommandData = new ComponentListCommandData;
				sComponentListCommandData.component = componentListModel.editorFile.component;//当前的顶级组件
				sComponentListCommandData.editorFile = componentListModel.editorFile;
				sendNotification(ComponentListCommand.CHANGED_COMPONENT, sComponentListCommandData);
				focusComponent(componentListModel.editorFile.component, componentListModel, rComponentListCommandData);
			}
			else if (notification.getName() == ADD_CHILD)
			{
				var sourceModel:SourceModel = facade.retrieveProxy(SourceModel.NAME) as SourceModel;
				fileModel = facade.retrieveProxy(FileModel.NAME) as FileModel;
				rComponentListCommandData = notification.getBody() as ComponentListCommandData;
				//create name
				name = fileModel.editorFileOperation.createComponentDefaultName();
				//create component
				component = ListComponentFactory.createComponent(name);
				component.componentTemplate = ComponentTemplateFactory.create(rComponentListCommandData.componentTemplateType);
				component.componentValueList = rComponentListCommandData.componentPropertyValueList;
				ComponentValueListFactory.filter(component);
				//source
				var textureComponentProperty:IComponentPropertyValue = component.componentValueList.getItem(ComponentPropertyEnum.TEXTURE) as IComponentPropertyValue;
				if (textureComponentProperty)
				{
					textureComponentProperty.propertyValue = ISource(fileModel.getSource(rComponentListCommandData.sourceName)).data;
				}
				//point
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				var localPoint:Point = componentListModel.currentContainerFocus.entity.globalToLocal(rComponentListCommandData.globalMousePoint);
				textureComponentProperty = component.componentValueList.getItem(ComponentPropertyEnum.X) as IComponentPropertyValue;
				if (textureComponentProperty)//x
				{
					textureComponentProperty.propertyValue = localPoint.x;
				}
				textureComponentProperty = component.componentValueList.getItem(ComponentPropertyEnum.Y) as IComponentPropertyValue;
				if (textureComponentProperty)//y
				{
					textureComponentProperty.propertyValue = localPoint.y;
				}
				//create display
				component.entity = ComponentDisplayFactory.createComponent(component);
				
				var componentModel:ComponentModel = facade.retrieveProxy(ComponentModel.NAME) as ComponentModel;
				//addChild
				ComponentControlUtils.addChild(componentListModel.editorFile.componentGroup, component, componentListModel.currentContainerFocus);
				
				sendNotification(ComponentListCommand.ADDED_CHILD, sComponentListCommandData);
				focusComponent(component, componentListModel, rComponentListCommandData);
			}
			else if (notification.getName() == FOCUS_OEPRATION)
			{
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				rComponentListCommandData = notification.getBody() as ComponentListCommandData;
				operationFocus(componentListModel, rComponentListCommandData, notification.getType());
			}
			else if (notification.getName() == DISPLAY_LAYER_OPERATION)
			{
				if (notification.getType() == TYPE_DISPLAY_LAYER_OPERATION_VISIBLE)
				{
					componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
					rComponentListCommandData = notification.getBody() as ComponentListCommandData;
					component = ComponentControlUtils.getComponentByName(componentListModel.editorFile.componentGroup, rComponentListCommandData.componentName) as IListComponent;
					if (component)
					{
						visibleComponent(component, componentListModel, rComponentListCommandData);
					}
					else
					{
						throw new Error("显示隐藏组件时，未查找到相应的名称");
					}
				}
				else if (notification.getType() == TYPE_DISPLAY_LAYER_OPERATION_FOCUS)//焦点
				{
					componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
					rComponentListCommandData = notification.getBody() as ComponentListCommandData;
					if (rComponentListCommandData.componentName == componentListModel.currentFocus.name)
					{
						return;//焦点重复
					}
					//				component = ComponentUtils.getTotalChildByName1(componentListModel.editorFile.component, rComponentListCommandData.componentName) as IListComponent;
					component = ComponentControlUtils.getComponentByName(componentListModel.editorFile.componentGroup, rComponentListCommandData.componentName) as IListComponent;
					if (component)
					{
						focusComponent(component, componentListModel, rComponentListCommandData);
					}
					else
					{
						throw new Error("焦点组件时，未查找到相应的名称");
					}
				}
				else if (notification.getType() == TYPE_DISPLAY_LAYER_OEPRATION_ISOPEN)
				{
					componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
					rComponentListCommandData = notification.getBody() as ComponentListCommandData;
					component = ComponentControlUtils.getComponentByName(componentListModel.editorFile.componentGroup, rComponentListCommandData.componentName) as IListComponent;
					if (component)
					{
						isOpenComponent(component, componentListModel, rComponentListCommandData);
					}
					else
					{
						throw new Error("isOpen组件时，未查找到相应的名称");
					}
				}
			}
		}
		/**
		 *操作组件
		 * @param component
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		private function operationComponent(component:IListComponent, componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData, type:String):void
		{
			ComponentValueListFactory.mix(component, rComponentListCommandData.componentPropertyValueList);	
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.component = component;
			sComponentListCommandData.componentPropertyValueList = rComponentListCommandData.componentPropertyValueList;
			sendNotification(ComponentListCommand.COMPONENT_OPERATION_REFRESHED, sComponentListCommandData, type);
		}
		/**
		 * 操作焦点组件
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		private function operationFocus(componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData, type:String):void
		{
			var component:IListComponent = componentListModel.currentFocus;
			operationComponent(component, componentListModel, rComponentListCommandData, type);
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.focus = component;
			sComponentListCommandData.componentPropertyValueList = rComponentListCommandData.componentPropertyValueList;
			sendNotification(ComponentListCommand.FOCUS_OPREATION_REFRESHED, sComponentListCommandData, type);
		}
		/**
		 *焦点组件 
		 * @param component
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		private function focusComponent(component:IListComponent, componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData):void
		{
			if (componentListModel.currentFocus) componentListModel.currentFocus.isFocus = false;
			componentListModel.currentFocus = component;
			component.isFocus = true;
			if (componentListModel.currentContainerFocus) componentListModel.currentContainerFocus.isFocusBeContainer = false;
			componentListModel.currentContainerFocus = ListComponentUtils.checkContainerComponent(componentListModel.editorFile.componentGroup, component);
			componentListModel.currentContainerFocus.isFocusBeContainer = true;
			
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.focus = componentListModel.currentFocus;
			sComponentListCommandData.containerFocus = componentListModel.currentContainerFocus;
			sComponentListCommandData.globalMousePoint = rComponentListCommandData.globalMousePoint;
			sComponentListCommandData.componentPoint = rComponentListCommandData.componentPoint;
			sComponentListCommandData.editorFile = componentListModel.editorFile;
			sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED, sComponentListCommandData, ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_FOCUS);
			sendNotification(ComponentListCommand.REFRESHED, sComponentListCommandData);
		}
		/**
		 *显示隐藏屏幕上的组建 
		 * @param component
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		private function visibleComponent(component:IListComponent, componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData):void
		{
			component.isView = !component.isView;
			
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.component = component;
			sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED, sComponentListCommandData, ComponentListCommand.TYPE_DISPLAY_LAYER_OPERATION_VISIBLE);
		}
		/**
		 *打开关闭组合 
		 * @param component
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		public function isOpenComponent(component:IListComponent, componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData):void
		{
			component.isOpen = !component.isOpen;
			
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.component = component;
			sComponentListCommandData.editorFile = componentListModel.editorFile;
			sComponentListCommandData.focus = componentListModel.currentFocus;
			sComponentListCommandData.containerFocus = componentListModel.currentContainerFocus;
			sendNotification(ComponentListCommand.DISPLAY_LAYER_OPERATION_REFRESHED, sComponentListCommandData, ComponentListCommand.TYPE_DISPLAY_LAYER_OEPRATION_ISOPEN);
		}
	}
}