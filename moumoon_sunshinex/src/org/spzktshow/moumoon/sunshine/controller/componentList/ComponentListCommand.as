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
		 *初始化model完成 
		 */		
		public static const INITED:String = "componentListCommandInited";
		/**
		 *当前组件列表 
		 */		
		public static const SET_OPERATE_COMPONENT_LIST:String = "componentListCommandSetOperationComponentList";
		/**
		 *设置当前组件完成 
		 */		
		public static const SET_OPERATE_COMPONENT_LIST_COMPLETE:String = "componentListCommandSetOperateComponentListComplete";
		/**
		 *添加顶级组件 ，相当于初始化的时候创建组件列表
		 */		
		public static const CREATE_COMPONENT:String = "componentListCommandAddComponent";
		/**
		 *添加顶级组件完成 
		 */		
		public static const CREATED_COMPONENT:String  = "componentListCommandAddedComponent";
		/**
		 *根据文件焦点的改变改变组件 
		 */		
		public static const CHANGE_COMPONENT:String = "componentListCommandChangeComponent";
		/**
		 *改变焦点组件完成 
		 */		
		public static const CHANGED_COMPONENT:String = "componentListCommandChangedComponent";
		/**
		 *焦点组件 
		 */		
		public static const FOCUS:String = "componentListCommandFocus";
		/**
		 *焦点组件完成 
		 */		
		public static const FOCUSED:String = "componentListCommandFocused";
		/**
		 *向当前的焦点的childComponent添加子组件 
		 */		
		public static const ADD_CHILD:String = "componentListCommandAddChild";
		/**
		 *向焦点组件添加子组件完成 
		 */		
		public static const ADDED_CHILD:String = "componentListCommandAddedChild";
		/**
		 *刷新 
		 */		
		public static const REFRESH:String = "componentListCommandRefresh";
		/**
		 *刷新完成 
		 */		
		public static const REFRESHED:String = "componentListCommandRefreshed";
		/**
		 *焦点组件操作,移动 
		 */		
		public static const FOCUS_OPERATION_MOVE:String = "componentListCommandFocusOperationMove";
		/**
		 * 焦点操作更新
		 * */
		public static const FOCUS_OPREATION_REFRESHED:String = "componentListCommandFocuseOperationRefreshed";
		/**
		 *显示某个组件 
		 */		
		public static const COMPONENT_OPERATION_VISIBLE:String = "componentListCommandComponentOperationVisible";
		/**
		 *组件操作更新 
		 */		
		public static const COMPONENT_OPERATION_REFRESHED:String = "componentListCommandComponentOperationRefreshed";
		
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
				
				componentListModel.currentFocus = componentListModel.editorFile.component as IListComponent;
				componentListModel.currentFocus.isFocus = true;
				componentListModel.currentContainerFocus = componentListModel.editorFile.component as IListComponent;
				componentListModel.currentContainerFocus.isFocusBeContainer = true;
				sComponentListCommandData = new ComponentListCommandData;
				sComponentListCommandData.focus = componentListModel.currentFocus;//当前的焦点组件
				sComponentListCommandData.containerFocus = componentListModel.currentContainerFocus;//当前作为容器的焦点组件
				sComponentListCommandData.component = componentListModel.editorFile.component;//当前的顶级组件
				sComponentListCommandData.editorFile = componentListModel.editorFile;
				sendNotification(ComponentListCommand.FOCUSED, sComponentListCommandData);
				sendNotification(ComponentListCommand.REFRESHED, sComponentListCommandData);
			}
			else if (notification.getName() == CHANGE_COMPONENT)
			{
				rComponentListCommandData = notification.getBody() as ComponentListCommandData;
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				componentListModel.editorFile = rComponentListCommandData.editorFile;
				componentListModel.currentFocus = componentListModel.editorFile.component as IListComponent;
				componentListModel.currentFocus.isFocus = true;
				componentListModel.currentContainerFocus = componentListModel.editorFile.component as IListComponent;
				componentListModel.currentContainerFocus.isFocusBeContainer = true;
				sComponentListCommandData = new ComponentListCommandData;
				sComponentListCommandData.focus = componentListModel.currentFocus;//当前的焦点组件
				sComponentListCommandData.containerFocus = componentListModel.currentContainerFocus;//当前作为容器的焦点组件
				sComponentListCommandData.component = componentListModel.editorFile.component;//当前的顶级组件
				sComponentListCommandData.editorFile = componentListModel.editorFile;
				sendNotification(ComponentListCommand.CHANGED_COMPONENT, sComponentListCommandData);
				sendNotification(ComponentListCommand.REFRESHED, sComponentListCommandData);
			}
			else if (notification.getName() == FOCUS)
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
			else if (notification.getName() == FOCUS_OPERATION_MOVE)
			{
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				rComponentListCommandData = notification.getBody() as ComponentListCommandData;
				operationFocus(componentListModel, rComponentListCommandData);
			}
			else if (notification.getName() == COMPONENT_OPERATION_VISIBLE)
			{
				componentListModel = facade.retrieveProxy(ComponentListModel.NAME) as ComponentListModel;
				rComponentListCommandData = notification.getBody() as ComponentListCommandData;
				component = componentListModel.editorFile.componentGroup.getItem(rComponentListCommandData.componentName) as IListComponent;
				operationComponent(component, componentListModel, rComponentListCommandData);
			}
		}
		/**
		 *操作组件
		 * @param component
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		private function operationComponent(component:IListComponent, componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData):void
		{
			ComponentValueListFactory.mix(component, rComponentListCommandData.componentPropertyValueList);	
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.component = component;
			sComponentListCommandData.componentPropertyValueList = rComponentListCommandData.componentPropertyValueList;
			sendNotification(ComponentListCommand.COMPONENT_OPERATION_REFRESHED, sComponentListCommandData);
		}
		/**
		 * 操作焦点组件
		 * @param componentListModel
		 * @param rComponentListCommandData
		 * 
		 */		
		private function operationFocus(componentListModel:ComponentListModel, rComponentListCommandData:ComponentListCommandData):void
		{
			var component:IListComponent = componentListModel.currentFocus;
			operationComponent(component, componentListModel, rComponentListCommandData);
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.focus = component;
			sComponentListCommandData.componentPropertyValueList = rComponentListCommandData.componentPropertyValueList;
			sendNotification(ComponentListCommand.FOCUS_OPREATION_REFRESHED, sComponentListCommandData);
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
			componentListModel.currentFocus.isFocus = false;
			componentListModel.currentFocus = component;
			component.isFocus = true;
			componentListModel.currentContainerFocus.isFocusBeContainer = false;
			componentListModel.currentContainerFocus = ListComponentUtils.checkContainerComponent(componentListModel.editorFile.componentGroup, component);
			componentListModel.currentContainerFocus.isFocusBeContainer = true;
			
			var sComponentListCommandData:ComponentListCommandData = new ComponentListCommandData;
			sComponentListCommandData.component = componentListModel.editorFile.component;
			sComponentListCommandData.focus = componentListModel.currentFocus;
			sComponentListCommandData.containerFocus = componentListModel.currentContainerFocus;
			sComponentListCommandData.globalMousePoint = rComponentListCommandData.globalMousePoint;
			sComponentListCommandData.componentPoint = rComponentListCommandData.componentPoint;
			sComponentListCommandData.editorFile = componentListModel.editorFile;
			sendNotification(ComponentListCommand.FOCUSED, sComponentListCommandData);
			sendNotification(ComponentListCommand.REFRESHED, sComponentListCommandData);
		}
	}
}