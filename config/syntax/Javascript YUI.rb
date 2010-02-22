# Encoding: UTF-8

{comment: "Yahoo User Interface Library 2.8.0",
 foldingStartMarker: /(?<_1>^.*{[^}]*$|^.*\([^\)]*$|^.*\/\*(?!.*\*\/).*$)/,
 foldingStopMarker: /(?<_1>^\s*\}|^\s*\)|^(?!.*\/\*).*\*\/)/,
 keyEquivalent: "^~J",
 name: "Javascript YUI",
 patterns: 
  [{match: /\b(?<_1>YAHOO|YAHOO_config)\b/, name: "support.class.js.yui"},
   {match: /\.(?<_1>util|lang|env|widget|example)\b/,
    name: "support.class.js.yui"},
   {match: 
     /\.(?<_1>CustomEvent|Subscriber|Event|EventProvider|Dom|Point|Region|Connect|DD|DDProxy|DDTarget|DragDrop|DragDropMgr|DDM|Anim|AnimMgr|Bezier|ColorAnim|Easing|Motion|Scroll|AutoComplete|DataSource|DS_JSArray|DS_JSFunction|DS_XHR|Config|KeyListener|Attribute|AttributeProvider|Element|History|Cookie|Get|ImageLoader|Resize|Selector|Storage|StorageEngineGears|StorageEngineHTML5|StorageEngineKeyed|StorageEngineSWF|StorageEvent|StorageManager|SWFStore|StyleSheet|YUILoader)\b/,
    name: "support.class.js.yui"},
   {match: 
     /\.(?<_1>AutoComplete|DataSource|DS_JSArray|DS_JSFunction|DS_XHR|Calendar|Calendar2up|Calendar_Core|CalendarGroup|DateMath|Module|Overlay|OverlayManager|Tooltip|Panel|Dialog|SimpleDialog|ContainerEffect|Logger|LogMsg|LogReader|LogWriter|Menu|MenuItem|Menubar|MenuBarItem|MenuManager|MenuModule|MenuModuleItem|ContextMenu|ContextMenuItem|Slider|SliderThumb|Tab|TabView|TreeView|Node|HTMLNode|MenuNode|TextNode|RootNode|TVAnim|TVFadeIn|TVFadeOut|Column|ColumnEditor|ColumnSet|DataTable|Record|RecordSet|Sort|WidthResizer|SWF|DateCellEditor|DropdownCellEditor|RadioCellEditor|ScrollingDataTable|TextareaCellEditor|TextboxCellEditor)\b/,
    name: "support.class.js.yui"},
   {match: /\.(?<_1>log|namespace|register)\b(?=\()/,
    name: "support.function.YAHOO.js.yui"},
   {match: 
     /\.(?<_1>augment|augmentObject|augmentProto|dump|extend|hasOwnProperty|isArray|isBoolean|isFunction|isNull|isNumber|isObject|isString|isUndefined|isValue|later|merge|substitute|trim|JSON)\b(?=\()/,
    name: "support.function.lang.js.yui"},
   {match: /\.(?<_1>getScope)\b(?=\()/,
    name: "support.function.Subscriber.js.yui"},
   {match: /\.(?<_1>fire|subscribe|unsubscribe|unsubscribeAll)\b(?=\()/,
    name: "support.function.CustomEvent.js.yui"},
   {match: 
     /\.(?<_1>addListener|clearCache|delegate|fireLegacyEvent|generateId|getCharCode|getEl|getEvent|getLegacyIndex|getListeners|getPageX|getPageY|getRelatedTarget|getTarget|getTime|getXY|on|onAvailable|onContentReady|onDOMReady|preventDefault|purgeElement|removeListener|resolveTextNode|startInterval|stopEvent|stopPropagation|useLegacyEvent)\b(?=\()/,
    name: "support.function.Event.js.yui"},
   {match: 
     /\.(?<_1>createEvent|fireEvent|hasEvent|subscribe|unsubscribe)\b(?=\()/,
    name: "support.function.EventProvider.js.yui"},
   {match: 
     /\.(?<_1>addClass|batch|generateId|get|getAncestorBy|getAncestorByClassName|getAncestorByTagName|getAttribute|getChildren|getChildrenBy|getClientHeight|getClientWidth|getClientRegion|getDocumentHeight|getDocumentScrollLeft|getDocumentScrollTop|getDocumentWidth|getElementBy|getElementsBy|getElementsByClassName|getFirstChild|getFirstChildBy|getLastChild|getLastChildBy|getNextSibling|getNextSiblingBy|getPreviousSibling|getPreviousSiblingBy|getRegion|getStyle|getViewportHeight|getViewportWidth|getX|getXY|getY|hasClass|inDocument|insertAfter|insertBefore|isAncestor|removeClass|replaceClass|setAttribute|setStyle|setX|setXY|setY)\b(?=\()/,
    name: "support.function.Dom.js.yui"},
   {match: /\.(?<_1>contains|getArea|intersect|union|getRegion)\b(?=\()/,
    name: "support.function.Region.js.yui"},
   {match: 
     /\.(?<_1>abort|appendPostData|asyncRequest|createExceptionObject|createFrame|createResponseObject|createXhrObject|getConnectionObject|handleReadyState|handleTransactionResponse|initHeader|isCallInProgress|releaseObject|resetDefaultHeaders|resetFormState|setDefaultPostHeader|setDefaultXhrHeader|setForm|setHeader|setPollingInterval|setProgId|uploadFile)\b(?=\()/,
    name: "support.function.Connect.js.yui"},
   {match: 
     /\.(?<_1>animate|doMethod|getAttribute|getDefaultUnit|getEl|getStartTime|init|isAnimated|onTween|setAttribute|setEl|setRuntimeAttribute|stop|toString)\b(?=\()/,
    name: "support.function.Anim.js.yui"},
   {match: 
     /\.(?<_1>correctFrame|registerElement|run|start|stop|unRegister)\b(?=\()/,
    name: "support.function.AnimMgr.js.yui"},
   {match: /\.(?<_1>getPosition)\b(?=\()/,
    name: "support.function.Bezier.js.yui"},
   {match: /\.(?<_1>parseColor)\b(?=\()/,
    name: "support.function.ColorAnim.js.yui"},
   {match: 
     /\.(?<_1>backBoth|backIn|backOut|bounceBoth|bounceIn|bounceOut|easeBoth|easeBothStrong|easeIn|easeInStrong|easeNone|easeOut|easeOutStrong|elasticBoth|elasticIn|elasticOut)\b/,
    name: "support.function.Easing.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.Motion.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.Scroll.js.yui"},
   {match: 
     /\.(?<_1>addInvalidHandleClass|addInvalidHandleId|addInvalidHandleType|addToGroup|applyConfig|b4Drag|b4DragDrop|b4DragOut|b4DragOver|b4EndDrag|b4MouseDown|b4StartDrag|clearConstraints|clearTicks|endDrag|getDragEl|getEl|getTick|handleMouseDown|handleOnAvailable|init|initTarget|isLocked|isValidHandleChild|lock|onAvailable|onDrag|onDragDrop|onDragEnter|onDragOut|onDragOver|onInvalidDrop|onMouseDown|onMouseUp|padding|removeFromGroup|removeInvalidHandleClass|removeInvalidHandleId|removeInvalidHandleType|resetContraints|setDragElId|setHandleElId|setInitPosition|setOuterHandleElId|setPadding|setStartPosition|setXConstraint|setXTicks|setYConstraint|setYTicks|startDrag|unlock|unreg)\b(?=\()/,
    name: "support.function.DragDrop.js.yui"},
   {match: 
     /\.(?<_1>fireEvents|getBestMatch|getClientHeight|getClientWidth|getCss|getDDById|getElement|getElWrapper|getLocation|getPosX|getPosY|getRelated|getScrollLeft|getScrollTop|getStyle|handleMouseDown|handleMouseMove|handleMouseUp|handleWasClicked|init|isDragDrop|isHandle|isLegalTarget|isLocked|isOverTarget|isTypeOfDD|lock|moveToEl|numericSort|refreshCache|regDragDrop|regHandle|removeDDFromGroup|startDrag|stopDrag|stopEvent|swapNode|unlock|unregAll|verifyEl)\b(?=\()/,
    name: "support.function.DragDropMgr.js.yui"},
   {match: 
     /\.(?<_1>alignElWithMouse|applyConfig|autoOffset|autoScroll|cachePosition|getTargetCoord|setDelta|setDragElPos)\b(?=\()/,
    name: "support.function.DD.js.yui"},
   {match: /\.(?<_1>createFrame|initFrame|showFrame)\b(?=\()/,
    name: "support.function.DDProxy.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.DDTarget.js.yui"},
   {match: 
     /\.(?<_1>getBookmarkedState|getCurrentState|getQueryStringParameter|initialize|multiNavigate|navigate|onReady|register)\b(?=\()/,
    name: "support.function.History.js.yui"},
   {match: 
     /\.(?<_1>addToCache|flushCache|getCachedResponse|handleResponse|isCacheHit|makeConnection|parseArrayData|parseJSONData|parseTextData|parseXMLData|sendRequest)\b(?=\()/,
    name: "support.function.DataSource.js.yui"},
   {match: 
     /\.(?<_1>doBeforeExpandContainer|formatResult|getListItemData|getListItems|isContainerOpen|sendQuery|setBody|setFooter|setHeader)\b(?=\()/,
    name: "support.function.AutoComplete.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.DS_JSArray.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.DS_JSFunction.js.yui"},
   {match: /\.(?<_1>parseResponse)\b(?=\()/,
    name: "support.function.DS_XHR.js.yui"},
   {match: 
     /\.(?<_1>addMonthRenderer|addMonths|addRenderer|addWeekdayRenderer|addYears|applyListeners|buildDayLabel|buildMonthLabel|buildWeekdays|clear|clearAllBodyCellStyles|clearElement|configClose|configIframe|configLocale|configLocaleValues|configMaxDate|configMinDate|configOptions|configPageDate|configSelected|configTitle|deselect|deselectAll|deselectCell|doCellMouseOut|doCellMouseOver|doSelectCell|getDateByCellId|getDateFieldsByCellId|getSelectedDates|hide|init|initEvents|initStyles|isDateOOM|nextMonth|nextYear|onBeforeDeselect|onBeforeSelect|onChangePage|onClear|onDeselect|onRender|onReset|onSelect|previousMonth|previousYear|refreshLocale|render|renderBody|renderBodyCellRestricted|renderCellDefault|renderCellNotThisMonth|renderCellStyleHighlight1|renderCellStyleHighlight2|renderCellStyleHighlight3|renderCellStyleHighlight4|renderCellStyleSelected|renderCellStyleToday|renderFooter|renderHeader|renderOutOfBoundsDate|renderRowFooter|renderRowHeader|reset|resetRenderers|select|selectCell|setMonth|setYear|show|styleCellDefault|subtractMonths|substractYears|validate)\b(?=\()/,
    name: "support.function.Calendar.js.yui"},
   {match: 
     /\.(?<_1>addMonthRenderer|addMonths|addRenderer|addWeekdayRenderer|addYears|callChildFunction|clear|configPageDate|configPages|constructChild|delegateConfig|deselect|deselectAll|deselectCell|getSelectedDates|init|initEvents|nextMonth|nextYear|previousMonth|previousYear|render|renderFooter|renderHeader|reset|select|selectCell|setChildFunction|setMonth|setYear|sub|subtractMonths|subtractYears|unsub)\b(?=\()/,
    name: "support.function.CalendarGroup.js.yui"},
   {match: 
     /\.(?<_1>add|after|before|between|clearTime|findMonthEnd|findMonthStart|getDayOffset|getJan1|getWeekNumber|isMonthOverlapWeek|isYearOverlapWeek|subtract)\b(?=\()/,
    name: "support.function.DateMath.js.yui"},
   {match: 
     /\.(?<_1>addProperty|alreadySubscribed|applyConfig|checkBoolean|checkNumber|fireEvent|fireQueue|getConfig|getProperty|init|outputEventQueue|queueProperty|refireEvent|refresh|resetProperty|setProperty|subscribeToConfigEvent|unsubscribeFromConfigEvent)\b(?=\()/,
    name: "support.function.Config.js.yui"},
   {match: /\.(?<_1>disable|enable|handleKeyPress)\b(?=\()/,
    name: "support.function.KeyListener.js.yui"},
   {match: 
     /\.(?<_1>appendToBody|appendToFooter|appendToHeader|configMonitorResize|configVisible|destroy|hide|init|initDefaultConfig|initEvents|initResizeMonitor|onDomResize|render|setBody|setFooter|setHeader|show)\b(?=\()/,
    name: "support.function.Module.js.yui"},
   {match: 
     /\.(?<_1>align|center|configConstrainToViewport|configContext|configFixedCenter|configHeight|configIframe|configVisible|configWidth|configX|configXY|configY|configZIndex|destroy|doCenterOnDOMEvent|enforceContraints|hideIframe|hideMacGeckoScrollbars|init|initDefaultConfig|initEvenrts|moveTo|onDomResize|showIframe|showMacGeckoScrollbars|syncPosition|windowResizeHandle|windowScrollHandler)\b(?=\()/,
    name: "support.function.Overlay.js.yui"},
   {match: 
     /\.(?<_1>blurAll|compareZIndexDesc|find|focus|getActive|hideAll|init|initDefaultConfig|register|remove|showAll)\b(?=\()/,
    name: "support.function.OverlayManager.js.yui"},
   {match: 
     /\.(?<_1>configContainer|configContext|configText|doHide|doShow|init|initDefaultConfig|onContextMouseMove|onContextMouseOut|onContextMouseOver|preventOverlay)\b(?=\()/,
    name: "support.function.Tooltip.js.yui"},
   {match: 
     /\.(?<_1>buildMask|buildWrapper|configClose|configDraggable|configHeight|configKeyListeners|configModal|configUnderlay|configWidth|configzIndex|hideMask|init|initDefaultConfig|initEvents|onDomResize|registerDragDrop|removeMask|render|showMask|sizeMask|sizeUnderlay)\b(?=\()/,
    name: "support.function.Panel.js.yui"},
   {match: 
     /\.(?<_1>blurButtons|cancel|configButtons|doSubmit|focusDefaultButton|focusFirst|focusFirstButton|focusLast|focusLastButton|getData|init|initDefaultConfig|initEvents|registerForm|submit|validate)\b(?=\()/,
    name: "support.function.Dialog.js.yui"},
   {match: 
     /\.(?<_1>configIcon|configText|init|initDefaultConfig|registerForm)\b(?=\()/,
    name: "support.function.SimpleDialog.js.yui"},
   {match: 
     /\.(?<_1>animateIn|animateOut|FADE|handleCompleteAnimateIn|handleCompleteAnimateOut|handleStartAnimateIn|handleStartAnimateOut|handleTweenAnimateIn|handleTweenAnimateOut|init|SLIDE)\b(?=\()/,
    name: "support.function.ContainerEffect.js.yui"},
   {match: 
     /\.(?<_1>disableBrowserConsole|enableBrowserConsole|getStack|getStartTime|log|reset)\b(?=\()/,
    name: "support.function.Logger.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.LogMsg.js.yui"},
   {match: 
     /\.(?<_1>formatMsg|getLastTime|hide|html2Text|pause|resume|setTitle|show)\b(?=\()/,
    name: "support.function.LogReader.js.yui"},
   {match: /\.(?<_1>getSource|log|setSource)\b(?=\()/,
    name: "support.function.LogWriter.js.yui"},
   {match: 
     /\.(?<_1>addItem|addItems|clearActiveItem|configContainer|configHideDelay|configIframe|configPosition|configVisible|destroy|disableAutoSubmenuDisplay|enforceConstraints|getItem|getItemGroups|getRoot|init|initDefaultConfig|initEvents|insertItem|onDomResize|removeItem|setInitialFocus|setInitialSelection|setItemGroupTitle)\b(?=\()/,
    name: "support.function.Menu.js.yui"},
   {match: 
     /\.(?<_1>blur|configChecked|configDisabled|configEmphasis|configHelpText|configSelected|configStrongEmphasis|configSubmenu|configTarget|configText|configUrl|destroy|focus|getFirstItemIndex|getNextArrayItem|getNextEnabledSibling|getPreviousArrayItem|getPreviousEnabledSibling|init|initDefaultConfig|initHelpText|removeHelpText)\b(?=\()/,
    name: "support.function.MenuItem.js.yui"},
   {match: /\.(?<_1>init|initDefaultConfig)\b(?=\()/,
    name: "support.function.Menubar.js.yui"},
   {match: /\.(?<_1>init)\b(?=\()/,
    name: "support.function.MenuBarItem.js.yui"},
   {match: 
     /\.(?<_1>addItem|addMenu|getMenu|getMenuRootElement|getMenus|hideVisible|onDOMEvent|onItemAdded|onItemDestroy|onItemRemoved|onMenuDestroy|onMenuVisibleConfigChange|removeItem|removeMenu)\b(?=\()/,
    name: "support.function.MenuManager.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.MenuModule.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/,
    name: "support.function.MenuModuleItem.js.yui"},
   {match: /\.(?<_1>configTrigger|destroy|init|initDefaultConfig)\b(?=\()/,
    name: "support.function.ContextMenu.js.yui"},
   {match: /\.(?<_1>init)\b(?=\()/,
    name: "support.function.ContextMenuItem.js.yui"},
   {match: 
     /\.(?<_1>b4MouseDown|endMove|fireEvents|focus|getThumb|getValue|getXValue|getYValue|handleThumbChange|lock|moveOneTick|moveThumb|onChange|onDrag|onMouseDown|onSliderEnd|onSlideStart|setRegionValue|setSliderStartState|setThumbCenterPoint|setValue|thumbMouseUp|unlock|verifyOffset|getHorizSlider|getSliderRegion|getVertSlider)\b(?=\()/,
    name: "support.function.Slider.js.yui"},
   {match: 
     /\.(?<_1>clearTicks|getOffsetFromParent|getValue|getXValue|getYValue|initSlider|onChange)\b(?=\()/,
    name: "support.function.SliderThumb.js.yui"},
   {match: 
     /\.(?<_1>configureAttribute|fireBeforeChangeEvent|fireChangeEvent|get|getAttributeConfig|getAttributeKeys|refresh|register|resetAttributeConfig|resetValue|set|setAttributes)\b(?=\()/,
    name: "support.function.AttributeProvider.js.yui"},
   {match: 
     /\.(?<_1>configure|getValue|refresh|resetConfig|resetValue|setValue|getValue|refresh|resetConfig|resetValue|setValue)\b(?=\()/,
    name: "support.function.Attribute.js.yui"},
   {match: 
     /\.(?<_1>addClass|addListener|appendChild|appendTo|fireQueue|getElementsByClassName|getElementsByTagName|getStyle|hasChildNodes|hasClass|initAttributes|insertBefore|on|removeChild|removeClass|removeListener|replaceChild|replaceClass|setStyle)\b(?=\()/,
    name: "support.function.Element.js.yui"},
   {match: 
     /\.(?<_1>addTab|contentTransition|createTabs|DOMEventHandler|getTab|getTabIndex|initAttributes|removeTab)\b(?=\()/,
    name: "support.function.TabView.js.yui"},
   {match: /\.(?<_1>initAttributes)\b(?=\()/,
    name: "support.function.Tab.js.yui"},
   {match: 
     /\.(?<_1>animateCollapse|animateExpand|collapseAll|collapseComplete|draw|expandAll|expandComplete|generateId|getEl|getNodeByIndex|getNodeByProperty|getNodesByProperty|getRoot|init|onCollapse|onExpand|popNode|regNode|removeChildren|removeNode|setCollapseAnim|setDynamicLoad|setExpandAnim|setUpLabel|addHandler|getNode|getTree|preload|removeHandler)\b(?=\()/,
    name: "support.function.TreeView.js.yui"},
   {match: 
     /\.(?<_1>appendChild|appendTo|applyParent|collapseToggleStyle|collapseAll|completeRender|expand|expandAll|getAncestor|getChildrenEl|getChildrenElId|getChildrenHtml|getDepthStyle|getEl|getElId|getHoverStyle|getHtml|getIconMode|getNodeHtml|getSiblings|getStyle|getToggleEl|getToggleElId|getToggleLink|hasChildren|hideChildren|init|insertAfter|insertBefore|isChildOf|isDynamic|isRoot|loadComplete|refresh|renderChildren|setDynamicLoad|showChildren|toggle)\b(?=\()/,
    name: "support.function.Node.js.yui"},
   {match: /\.(?<_1>getContentEl)\b(?=\()/,
    name: "support.function.HTMLNode.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.MenuNode.js.yui"},
   {match: /\.(?<_1>getLabelEl|onLabelClick)\b(?=\()/,
    name: "support.function.TextNode.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.RootNode.js.yui"},
   {match: /\.(?<_1>getAnim|isValid)\b(?=\()/,
    name: "support.function.TVAnim.js.yui"},
   {match: /\.(?<_1>animate|onComplete)\b(?=\()/,
    name: "support.function.TVFadeIn.js.yui"},
   {match: /\.(?<_1>animate|onComplete)\b(?=\()/,
    name: "support.function.TVFadeOut.js.yui"},
   {match: 
     /\.(?<_1>format|formatCheckbox|formatCurrency|formatDate|formatEmail|formatLink|formatNumber|formatSelect|getColSpan|getId|getRowSpan|parse|parseCheckbox|parseCurrency|parseDate|parseNumber|parseSelect|showEditor)\b(?=\()/,
    name: "support.function.Column.js.yui"},
   {match: 
     /\.(?<_1>createTextareaEditor|createTextboxEditor|getTextareaEditorValue|getTextboxEditorValue|getValue|hide|show|showTextareaEditor|showTextboxEditor)\b(?=\()/,
    name: "support.function.ColumnEditor.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.ColumnSet.js.yui"},
   {match: 
     /\.(?<_1>addRow|appendRow|deleteRow|deleteSelectedRows|doBeforeLoadData|editCell|focusTable|formatCell|getBody|getCell|getColumnSet|getHead|getRecordSet|getRow|getSelectedCells|getSelectedRecordIds|getSelectedRows|getTable|hideTableMessages|highlight|insertRows|isSelected|onDataReturnAppendRows|onDataReturnInsertRows|onDataReturnPaginateRows|onDataReturnReplaceRows|onEventEditCell|onEventFormatCell|onEventHighlightCell|onEventSelectCell|onEventSelectRow|onEventSortColumn|onEventUnhighlightCell|paginateRows|replaceRows|select|showEmptyMessage|showLoadingMessage|showPage|sortColumn|unhighlight|unselect|unselectedAllCells|unselectAllRows|updateRow)\b(?=\()/,
    name: "support.function.DataTable.js.yui"},
   {match: /\.(?<_1>)\b(?=\()/, name: "support.function.Record.js.yui"},
   {match: 
     /\.(?<_1>addRecord|addRecords|append|deleteRecord|getLength|getRecord|getRecordBy|getRecordIndex|getRecords|insert|replace|reset|sort|updateRecord)\b(?=\()/,
    name: "support.function.RecordSet.js.yui"},
   {match: /\.(?<_1>compareAsc|compareDesc)\b(?=\()/,
    name: "support.function.Sort.js.yui"},
   {match: /\.(?<_1>onDrag|onMouseDown|onMouseUp)\b(?=\()/,
    name: "support.function.WidthResizer.js.yui"},
   {match: 
     /\.(?<_1>exists|get|getSub|getSubs|remove|removeSubs|set|setSub|setSubs)\b(?=\()/,
    name: "support.function.Cookie.js.yui"},
   {match: /\.(?<_1>abort|css|script)\b(?=\()/,
    name: "support.function.Get.js.yui"},
   {match: 
     /\.(?<_1>bgImgObj|fetch|group|imgObj|pngBgImgObj|srcImgObj)\b(?=\()/,
    name: "support.function.ImageLoader.js.yui"},
   {match: /\.(?<_1>dateToString|isSafe|parse|stringify|stringToDate)\b(?=\()/,
    name: "support.function.JSON.js.yui"},
   {match: 
     /\.(?<_1>destroy|getActiveHandleEl|getProxyEl|getResizeById|getStatusEl|getWrapEl|isActive|isLocked|lock|reset|toString|unlock)\b(?=\()/,
    name: "support.function.Resize.js.yui"},
   {match: /\.(?<_1>filter|query|test)\b(?=\()/,
    name: "support.function.Selector.js.yui"},
   {match: /\.(?<_1>clear|getItem|getName|hasKey|key|setItem)\b(?=\()/,
    name: "support.function.Storage.js.yui"},
   {match: /\.(?<_1>get|register)\b(?=\()/,
    name: "support.function.StorageManager.js.yui"},
   {match: 
     /\.(?<_1>addListener|calculateCurrentSize|clear|displaySettings|getItems|getLength|getModificationDate|getShareData|getTypeAt|getTypeOf|getUseCompression|getValueAt|getValueOf|hasAdequateDimensions|on|removeItem|setItem|setShareData|setSize|setUseCompression|toString)\b(?=\()/,
    name: "support.function.SWFStore.js.yui"},
   {match: /\.(?<_1>callSWF|toString)\b(?=\()/,
    name: "support.function.SWF.js.yui"},
   {match: 
     /\.(?<_1>disable|enable|getCssText|getId|isEnabled|set|isValidSelector|register|toCssText|unset)\b(?=\()/,
    name: "support.function.StyleSheet.js.yui"},
   {match: 
     /\.(?<_1>addModule|calculate|formatSkin|getProvides|getRequires|insert|loadNext|onFailure|onProgress|onSuccess|onTimeout|parseSkin|require|sandbox)\b(?=\()/,
    name: "support.function.YUILoader.js.yui"},
   {match: 
     /\.(?<_1>focus|getInputValue|handleDisabledBtns|renderForm|resetForm)\b(?=\()/,
    name: "support.function.DateCellEditor.js.yui"},
   {match: 
     /\.(?<_1>focus|getInputValue|handleDisabledBtns|renderForm|resetForm)\b(?=\()/,
    name: "support.function.DropdownCellEditor.js.yui"},
   {match: 
     /\.(?<_1>focus|getInputValue|handleDisabledBtns|renderForm|resetForm)\b(?=\()/,
    name: "support.function.RadioCellEditor.js.yui"},
   {match: 
     /\.(?<_1>disable|getBdContainerEl|getBdTableEl|getHdContainerEl|getHdTableEl|insertColumn|onColumnChange|removeColumn|reorderColumn|scrollTo|setColumnWidth|showTableMessage|validateColumnWidths)\b(?=\()/,
    name: "support.function.ScrollingDataTable.js.yui"},
   {match: 
     /\.(?<_1>focus|getInputValue|handleDisabledBtns|move|renderForm|resetForm)\b(?=\()/,
    name: "support.function.TextareaCellEditor.js.yui"},
   {match: /\.(?<_1>focus|getInputValue|move|renderForm|resetForm)\b(?=\()/,
    name: "support.function.TextboxCellEditor.js.yui"},
   {include: "source.js"}],
 scopeName: "source.js.yui",
 uuid: "62E7EF93-5574-4063-BF18-AD38620236B9"}
