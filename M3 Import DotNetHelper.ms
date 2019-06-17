
dotnet.loadAssembly @"$Temp\M3Import_mzp\MaxCustomControls_2011.dll"
struct M3S_DotNetClass
(
	enumClass,
	viewClass,
	sortClass,
	columnHeaderStyleClass,
	imageClass,
	bitmapClass,
	colorClass,
	fontClass,
	dockClass,
	anchorClass,
	dragDropEffectsClass,
	listViewItemClass,
	AppearanceClass,
	ContentAlignmentClass,

	fn createCtl type_FP n: x: y: w: h: a: v:"Left" t:"" ta: bc: =
	(
		local control
		case type_FP of
		(
			#Form: control = dotNetObject "System.Windows.Forms.Form"
			#SplitContainer: control = dotNetObject "System.Windows.Forms.SplitContainer"
			#GroupBox: control = dotNetObject "System.Windows.Forms.GroupBox"
			#Button: control = dotNetObject "System.Windows.Forms.Button"
			#RadioButton: control = dotNetObject "System.Windows.Forms.RadioButton"
			#Label: control = dotNetObject "System.Windows.Forms.Label"
			#ListView: control = dotNetObject "System.Windows.Forms.ListView"
			#TextBox: control = dotNetObject "System.Windows.Forms.TextBox"
			#CheckBox: control = dotNetObject "System.Windows.Forms.CheckBox"
			#ComboBox: control = dotNetObject "System.Windows.Forms.ComboBox"
			#ProgressBar: control = dotNetObject "System.Windows.Forms.ProgressBar"

			#ListViewItem: control = dotNetObject "System.Windows.Forms.ListViewItem" t
			default:(return undefined)
		)
		if(n != unsupplied)then
		(
			control.Name = n
		)
		case a of
		(
			#Anchor:
			(
				control.Anchor = (this.getClass #Enum).Parse (this.getClass #Anchor) v
			)
			#Dock:
			(
				case v of
				(
					"None": control.Dock = (this.getClass #Dock).None
					"Left": control.Dock = (this.getClass #Dock).Left
					"Right": control.Dock = (this.getClass #Dock).Right
					"Top": control.Dock = (this.getClass #Dock).Top
					"Bottom": control.Dock = (this.getClass #Dock).Bottom
					"Fill": control.Dock = (this.getClass #Dock).Fill
				)
			)
			default:()
		)
		if(x != unsupplied and y != unsupplied)then
		(
			control.Location = dotNetObject "System.Drawing.Point" x y
		)
		if(w != unsupplied)then
		(
			control.Width = w
		)
		if(h != unsupplied)then
		(
			control.Height = h
		)
		if(t.count != 0)then
		(
			control.Text = t
		)
		if(ta != unsupplied)then
		(
			case ta of
			(
				#BottomCenter: control.TextAlign = (this.getClass #ContentAlignment).BottomCenter
				#BottomLeft: control.TextAlign = (this.getClass #ContentAlignment).BottomLeft
				#BottomRight: control.TextAlign = (this.getClass #ContentAlignment).BottomRight
				#MiddleCenter: control.TextAlign = (this.getClass #ContentAlignment).MiddleCenter
				#MiddleLeft: control.TextAlign = (this.getClass #ContentAlignment).MiddleLeft
				#MiddleRight: control.TextAlign = (this.getClass #ContentAlignment).MiddleRight
				#TopCenter: control.TextAlign = (this.getClass #ContentAlignment).TopCenter
				#TopLeft: control.TextAlign = (this.getClass #ContentAlignment).TopLeft
				#TopRight: control.TextAlign = (this.getClass #ContentAlignment).TopRight
			)
		)
		if(bc != unsupplied)then
		(
			case (classOf bc) of
			(
				Float: control.BackColor = (this.getClass #Color).FromArgb bc
				color: control.BackColor = (this.getClass #Color).FromArgb bc.r bc.g bc.b
				Point3: control.BackColor = (this.getClass #Color).FromArgb bc[1] bc[2] bc[3]
				Point4: control.BackColor = (this.getClass #Color).FromArgb bc[4] bc[1] bc[2] bc[3]
				Array:
				(
					case bc.count of
					(
						1: control.BackColor = (this.getClass #Color).FromArgb bc[1]
						3: control.BackColor = (this.getClass #Color).FromArgb bc[1] bc[2] bc[3]
						4: control.BackColor = (this.getClass #Color).FromArgb bc[4] bc[1] bc[2] bc[3]
					)
				)
			)
		)
		control
	),

	fn createImageList type_FP path_FP =
	(
		local i
		local image_list = dotNetObject "System.Windows.Forms.ImageList"

		case type_FP of
		(
			#Bitmap:
			(
				for i=1 to path_FP.count do
				(
					image_list.Images.Add ((this.getClass #Bitmap).FromFile path_FP[i])
				)
			)
			#Image:
			(
				for i=1 to path_FP.count do
				(
					image_list.Images.Add ((this.getClass #Image).FromFile path_FP[i])
				)
			)
		)

		image_list
	),

	fn createObject type_FP d1: d2: =
	(
		local net_obj
		case type_FP of
		(
			#Point:
			(
				local pos_x = if(d1 != unsupplied)then(d1)else(0)
				local pos_y = if(d2 != unsupplied)then(d2)else(0)
				net_obj = dotNetObject "System.Drawing.Point" pos_x pos_y
			)
			#Size:
			(
				local width = if(d1 != unsupplied)then(d1)else(0)
				local height = if(d2 != unsupplied)then(d2)else(0)
				net_obj = dotNetObject "System.Drawing.Size" width height
			)
			#Font:
			(
				local font_name = if(d1 != unsupplied)then(d1)else("Tahoma")
				local font_size = if(d2 != unsupplied)then(d2)else(8.5)
				net_obj = dotNetObject "System.Drawing.Font" font_name font_size
			)
			#Icon:
			(
				if(d1 != unsupplied)then
				(
					local icon_size = if(d2 != unsupplied)then(d2)else(32)
					net_obj = dotNetObject "System.Drawing.Icon" d1 icon_size icon_size
				)
			)
			#IntPtr:
			(
				if(d1 != unsupplied)then
				(
					net_obj = DotNetObject "System.IntPtr" d1
				)
			)
			#Handle:
			(
				if(d1 != unsupplied)then
				(
					local dot_ptr = case classOf d1 of
					(
						Integer: DotNetObject "System.IntPtr" (d1 as IntegerPtr)
						IntegerPtr: DotNetObject "System.IntPtr" d1
						dotNetObject: d1
						default: return undefined
					)
					net_obj = DotNetObject "MaxCustomControls.Win32HandleWrapper" dot_ptr
				)
			)
			default:(return undefined)
		)
		net_obj
	),

	fn getClass class_FP =
	(
		case class_FP of
		(
			#Enum:
			(
				if(this.enumClass == undefined)then
				(this.enumClass = dotNetClass "System.Enum")
				this.enumClass
			)
			#View:
			(
				if(this.viewClass == undefined)then
				(this.viewClass = dotNetClass "System.Windows.Forms.View")
				this.viewClass
			)
			#Sort:
			(
				if(this.sortClass == undefined)then
				(this.sortClass = dotNetClass "System.Windows.Forms.SortOrder")
				this.sortClass
			)
			#ColumnHeaderStyle:
			(
				if(this.columnHeaderStyleClass == undefined)then
				(this.columnHeaderStyleClass = dotNetClass "System.Windows.Forms.ColumnHeaderStyle")
				this.columnHeaderStyleClass
			)
			#Image:
			(
				if(this.imageClass == undefined)then
				(this.imageClass = dotNetClass "System.Drawing.Image")
				this.imageClass
			)
			#Bitmap:
			(
				if(this.bitmapClass == undefined)then
				(this.bitmapClass = dotNetClass "System.Drawing.Bitmap")
				this.bitmapClass
			)
			#Color:
			(
				if(this.colorClass == undefined)then
				(this.colorClass = dotNetClass "System.Drawing.Color")
				this.colorClass
			)
			#Font:
			(
				if(this.fontClass == undefined)then
				(this.fontClass = dotNetClass "System.Drawing.Font")
				this.fontClass
			)
			#Dock:
			(
				if(this.dockClass == undefined)then
				(this.dockClass = dotNetClass "System.Windows.Forms.DockStyle")
				this.dockClass
			)
			#Anchor:
			(
				if(this.anchorClass == undefined)then
				(this.anchorClass = dotNetClass "System.Windows.Forms.AnchorStyles")
				this.anchorClass
			)
			#DragDropEffects:
			(
				if(this.dragDropEffectsClass == undefined)then
				(this.dragDropEffectsClass = dotNetClass "System.Windows.Forms.DragDropEffects")
				this.dragDropEffectsClass
			)
			#ListViewItem:
			(
				if(this.listViewItemClass == undefined)then
				(this.listViewItemClass = dotNetClass "System.Windows.Forms.ListViewItem")
				this.listViewItemClass
			)
			#Appearance:
			(
				if(this.AppearanceClass == undefined)then
				(this.AppearanceClass = dotNetClass "System.Windows.Forms.Appearance")
				this.AppearanceClass
			)
			#ContentAlignment:
			(
				if(this.ContentAlignmentClass == undefined)then
				(this.ContentAlignmentClass = dotNetClass "System.Drawing.ContentAlignment")
				this.ContentAlignmentClass
			)
			default: undefined
		)
	)
)