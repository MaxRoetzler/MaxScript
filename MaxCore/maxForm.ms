/*
*/

(
	struct maxForm
	(

---------------------------
-- .NET | SYSTEM DRAWING --
---------------------------

		public function GetPoint x y =
		(
			/*	Get the drawing point for the specified coordinates.

				@X				Integer				The x coordinate.
				@Y				Integer				The y coordinate.

				@Return			Point				The .Net drawing point.
			*/

			DotNetObject "System.Drawing.Point" x y;
		),

		public function GetCursor =
		(
			/*	Get the drawing point at the mouse cursor position.

				@Return			Point				The .Net drawing point.
			*/

			(DotNetClass "System.Windows.Forms.Cursor").position;
		),

		public function GetSize width height =
		(
			/*	Get the drawing size of specified width and height.

				@Width			Integer				The width value.
				@Height			Integer				The height value.

				@Return			Size				The .Net drawing size.
			*/

			DotNetObject "System.Drawing.Size" width height;
		),

		public function GetRect x y width height =
		(
			/*	Get the drawing rectangle, specified by x,y and width, height.

				@X				Integer				The x coordinate.
				@Y				Integer				The y coordinate.
				@Width			Integer				The width value.
				@Height			Integer				The height value.

				@Return			Rectangle			The .Net drawing rectangle.
			*/

			DotNetObject "System.Drawing.Rectangle" x y width height;
		),

		public function GetImage file =
		(
			/*	Get the drawing image from the specified image file path.

				@File			String				The image file path.

				@Return			Image				The .Net drawing image.
			*/

			(DotNetClass "System.Drawing.Image").FromFile file;
		),

		public function GetColor color =
		(
			/*	Get the drawing color from the max script color value.

				@Color			Integer				The color value.

				@Return			Color				The .Net drawing color.
			*/

			(DotNetClass "System.Drawing.Color").FromArgb color.r color.g color.b;
		),

		public function GetDefaultColor name =
		(
			/*	Get the drawing color from the 3ds max default colors.

				@Name			String				The default color name.

				@Return			Color				The .Net drawing color.
			*/

			maxForm.GetColor ((Colorman.GetColor name * 255) as color);
		),

----------------------------
-- .NET | FORM ATTRIBUTES --
----------------------------

		public function GetBorderStyle style =
		(
			/*	Get the border style attribute.

				@Style			Enum				The border style.

				@Return			BorderStyle			The .Net border style attribute.
			*/

			case style of
			(
				#Fixed3D		: (DotNetClass "System.Windows.Forms.BorderStyle").Fixed3D;
				#FixedSingle	: (DotNetClass "System.Windows.Forms.BorderStyle").FixedSingle;
				#None			: (DotNetClass "System.Windows.Forms.BorderStyle").None;
			)
		),

		public function GetFormBorderStyle style =
		(
			/*	Get the form border style attribute.

				@Style			Enum				The border style.

				@Return			FormBorderStyle		The .Net form border style attribute.
			*/

			case style of
			(
				#Fixed3D 			: (DotNetClass "System.Windows.Forms.FormBorderStyle").Fixed3D;
				#FixedDialog 		: (DotNetClass "System.Windows.Forms.FormBorderStyle").FixedDialog;
				#FixedSingle 		: (DotNetClass "System.Windows.Forms.FormBorderStyle").FixedSingle;
				#None 				: (DotNetClass "System.Windows.Forms.FormBorderStyle").None;
				#Sizable 			: (DotNetClass "System.Windows.Forms.FormBorderStyle").Sizable;
				#SizableToolWindow	: (DotNetClass "System.Windows.Forms.FormBorderStyle").SizableToolWindow;
			)
		),

		public function GetFlatStyle style =
		(
			/*	Get the flat style attribute.

				@Style			Enum				The flat style.

				@Return			FlatStyle			The .Net flat style attribute.
			*/

			case style of
			(
				#Flat		: (DotNetClass "System.Windows.Forms.FlatStyle").Flat;
				#Popup		: (DotNetClass "System.Windows.Forms.FlatStyle").Popup;
				#Standard	: (DotNetClass "System.Windows.Forms.FlatStyle").Standard;
				#System		: (DotNetClass "System.Windows.Forms.FlatStyle").System;
			)
		),

		public function GetContentAlignment align =
		(
			/*	Get the content alignment attribute.

				@Align			Enum				The content aligment style.

				@Return			ContentAlignment	The .Net content alignment attribute.
			*/

			case align of
			(
				#BottomCenter	: (DotNetClass "System.Drawing.ContentAlignment").BottomCenter;
				#BottomLeft		: (DotNetClass "System.Drawing.ContentAlignment").BottomLeft;
				#BottomRight	: (DotNetClass "System.Drawing.ContentAlignment").BottomRight;
				#MiddleCenter	: (DotNetClass "System.Drawing.ContentAlignment").MiddleCenter;
				#MiddleLeft		: (DotNetClass "System.Drawing.ContentAlignment").MiddleLeft;
				#MiddleRight	: (DotNetClass "System.Drawing.ContentAlignment").MiddleRight;
				#TopCenter		: (DotNetClass "System.Drawing.ContentAlignment").TopCenter;
				#TopLeft		: (DotNetClass "System.Drawing.ContentAlignment").Topleft;
				#TopRight		: (DotNetClass "System.Drawing.ContentAlignment").TopRight;
			)
		),

		public function GetCheckState state =
		(
			/*	Get the check state attribute for specified state.

				@State		Boolean			The check state.

				@Return		CheckState		The .Net check state attribute.
			*/

			case state of
			(
				true 	: (DotNetClass "System.Windows.Forms.CheckState").Checked;
				false	: (DotNetClass "System.Windows.Forms.CheckState").Unchecked;
			)
		),

------------------------------
-- .NET | FORM AND CONTROLS --
------------------------------

		public function Form title width height point: border:#FixedSingle =
		(
			/*	Create a max form, assign the specified and default attributes.

				@Title				String				The form title.
				@Width				Integer				The width value.
				@Height				Integer				The height value.
				@Point				Point2				Optional position, mouse cursor by default.
				@Border				Enum				Optional border style, #FixedSingle by default.

				@Return				MaxForm				The .Net max form.
			*/

			case point of
			(
				unsupplied	: point = GetCursor ();
				default		: point = GetPoint point.x point.y;
			)

			local control = DotNetObject "MaxCustomControls.MaxForm";

			control.FormBorderStyle = GetFormBorderStyle border;
			control.StartPosition = control.StartPosition.Manual;
			control.Size = GetSize width height;
			control.MinimumSize = GetSize 1 1;
			control.Location = point;
			control.Text = title;

			control;
		),

		public function Image file x y width height =
		(
			/*	Create a label control displaying an image.

				@File				String				The image file path.
				@X					Integer				The x coordinate.
				@Y					Integer				The y coordinate.
				@Width				Integer				The width value.
				@Height				Integer				The height value.

				@Return				Label				The .Net label control.
			*/

			local control = DotNetObject "System.Windows.Forms.Label";

			control.Bounds = GetRect x y width height;
			control.Image = GetImage file;

			control;
		),

		public function Label text x:0 y:0 width:60 height:20 align:#MiddleLeft =
		(
			/*	Create a label control, assign the specified and default attributes.

				@Text				String				The label text.
				@X					Integer				The x coordinate.
				@Y					Integer				The y coordinate.
				@Width				Integer				The width value.
				@Height				Integer				The height value.
				@Align				Enum				Optional content alignment, #TopLeft by default.

				@Return				Label				The .Net label control.
			*/

			local control = DotNetObject "System.Windows.Forms.Label";

			control.BackColor = GetDefaultColor #Background;
			control.ForeColor = GetDefaultColor #Text;
			control.TextAlign = GetContentAlignment align;
			control.Bounds = GetRect x y width height;
			control.Text = text;

			control;
		),

		public function Button tag text name:"" x:0 y:0 width:60 height:20 style:#Flat border:1 =
		(
			/*	Create a button control, assign the specified and default attributes.

				@Text				String				The button text.
				@X					Integer				The x coordinate.
				@Y					Integer				The y coordinate.
				@Width				Integer				The width value.
				@Height				Integer				The height value.
				@Style				Enum				Optional border style, #Flat by default.
				@Border				Integer				Optional border width, 0 by default.

				@Return				Label				The .Net button control.
			*/

			local control = DotNetObject "System.Windows.Forms.Button";

			control.BackColor = GetDefaultColor #Background;
			control.ForeColor = GetDefaultColor #Text;
			control.FlatAppearance.BorderSize = border;
			control.Bounds = GetRect x y width height;
			control.FlatStyle = GetFlatStyle style;
			control.Tag = DotNetMxsValue tag;
			control.Name = name;
			control.Text = text;

			control;
		),

		public function CheckBox tag state name:"" x:0 y:0 width:20 height:20 =
		(
			local control = DotNetObject "System.Windows.Forms.CheckBox";

			control.BackColor = GetDefaultColor #Background;
			control.ForeColor = GetDefaultColor #Text;
			control.Bounds = GetRect x y width height;
			control.Tag = DotNetMxsValue tag;
			control.Checked = state;
			control.Name = name;

			control;
		),

		public function ComboBox tag items name:"" x:0 y:0 width:60 height:20 index:-1 =
		(
			/*	Create a combo box control, assign the specified and default attributes.

				@Name				Sting				The control's name.
				@X					Integer				The x coordinate.
				@Y					Integer				The y coordinate.
				@Width				Integer				The width value.
				@Height				Integer				The height value.
				@Tag				Object				Optional control tag, undefined by default.
				@Items				Array				Optional combo box items, empty array by default.
				@Index				Integer				Optional selection index, -1 by default.

				@Return				ComboBox			The .Net combo box control.
			*/

			local control = DotNetObject "System.Windows.Forms.ComboBox";

			control.BackColor = GetDefaultColor #Background;
			control.ForeColor = GetDefaultColor #Text;
			control.Bounds = GetRect x y width height;
			control.Tag = DotNetMxsValue tag;
			control.Items.AddRange items;
			control.SelectedIndex = index;
			control.Name = name;

			control;
		),

		public function TextBox tag name text x:0 y:0 width:60 height:20 multiline:false keys:true style:#Fixed3D =
		(
			/*	Create a text box control, assign the specified and default attributes.

				@Name				Sting				The control's name.
				@Text				Sting				The default text.
				@X					Integer				The x coordinate.
				@Y					Integer				The y coordinate.
				@Width				Integer				The width value.
				@Height				Integer				The height value.
				@Tag				Object				Optional control tag, undefined by default.
				@Multiline			Boolean				The multiline attribute defining tab and enter behavior.
				@Keys				Boolean				The modifier keys
				@Style				Enum				Optional border style, #Fixed3D by default.

				@Return				TextBox				The .Net text box control.
			*/

			local control = DotNetObject "System.Windows.Forms.TextBox";

			control.BackColor = GetDefaultColor #Background;
			control.ForeColor = GetDefaultColor #Text;
			control.BorderStyle = GetBorderStyle style;
			control.Bounds = GetRect x y width height;
			control.Tag = DotNetMxsValue tag;
			control.MultiLine = multiline;
			control.AcceptsReturn = keys;
			control.AcceptsTab = keys;
			control.Name = name;
			control.Text = text;

			control;
		),

		public function Context opacity:1.0 =
		(
			/*	Create a context menu, assign the specified and default attributes.

				@Opacity			Float				The context menu opacity.

				@Return				ContextMenuStrip	The .Net context menu.
			*/

			local control = DotNetObject "System.Windows.Forms.ContextMenuStrip";

			control.BackColor = GetDefaultColor #Background;
			control.ForeColor = GetDefaultColor #Text;

			if (opacity < 1.0) do
			(
				control.AllowTransparency = true;
				control.Opacity = opacity;
			)

			DotNet.AddEventHandler control "Opened" (fn OnOpened s e = enableAccelerators = false);
			DotNet.AddEventHandler control "Closed" (fn OnClosed s e = enableAccelerators = true);

			control;
		),

		public function ContextItem text keys:false state: =
		(
			/*	Create a context menu item, assign the specified and default attributes.

				@Text				String				The item name.
				@State				Boolean				Optional item checked state.

				@Return				ToolStripMenuItem	The .Net context menu item.
			*/

			local control = DotNetObject "System.Windows.Forms.ToolStripMenuItem";

			control.Text = text;
			control.CheckOnClick = true;
			control.ShowShortcutKeys = keys;
			control.ShortcutKeyDisplayString = text[1];

			if (state != unsupplied) do
			(
				control.CheckState = GetCheckState state;
			)

			control;
		),

		public function ContextSeparator =
		(
			/*	Create a context menu separator.

				@Return				ToolStripSeparator	The .Net context menu separator.
			*/

			DotNetObject "System.Windows.Forms.ToolStripSeparator";
		)
	)

	-- Register to core
	Core.Form = maxForm ();
)