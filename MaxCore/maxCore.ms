/*
*/

(
	struct maxCore
	(
		public Form,
		public Line,
		public Math,
		public Node,
		public Poly,
		public Util,

		private m_time,
		private m_modules = #(),
		private m_observers = #(),
		private m_directory = "",

------------------------
-- CORE | DIRECTORIES --
------------------------

		public function GetDirectory folder =
		(
			m_directory + "\\" + folder;
		),

--------------------
-- CORE | MODULES --
--------------------

		private Module = struct Module
		(
			public Name,
			public Class,
			public Object,

			public function GetInstance =
			(
				if (Object == undefined) do
				(
					Object = Class ();
					Object.OnEnable ();
				)

				Object;
			),

			public function Dispose =
			(
				Object.OnDisable ();
				Object = undefined;
			)
		);,

		private function FindModule name =
		(
			/*
			*/

			local result;

			for module in m_modules while (result == undefined) do
			(
				if (module.Name == name) do
				(
					result = module;
				)
			)

			result;
		),

		public function GetModule name =
		(
			/*
			*/

			local module = FindModule name;

			if (module != undefined) do
			(
				module = module.GetInstance ();
			)

			module;
		),

		public function DropModule name =
		(
			/*
			*/

			local module = FindModule name;

			if (module != undefined) do
			(
				module.Dispose ();
			)
		),

		public function RegisterModule name class =
		(
			/*
			*/

			if (ClassOf class == StructDef and FindModule name == undefined) do
			(
				Append m_modules (Module Name:name Class:class);
			)
		),

		public function UnregisterModule name =
		(
			/*
			*/

			local search = true;

			for i = m_modules.Count to 1 by -1 while search do
			(
				if (m_modules[i].Name == name) do
				(
					DeleteItem m_modules i;

					search = false;
				)
			)
		),

		public function ListModules =
		(
			for module in m_modules do
			(
				format "[Module | %] Loaded: %\n" module.Name (module.Object != undefined)
			)
		),

-------------------
-- CORE | EVENTS --
-------------------

		public function Subscribe observer =
		(
			/*
			*/

			local index = FindItem m_observers observer;

			if (index == 0) do
			(
				Append m_observers observer;
			)
		),

		public function Unsubscribe observer =
		(
			/*
			*/

			local index = FindItem m_observers observer;

			if (index != 0) do 
			(
				DeleteItem m_observers index;
			)
		),

		public function RaiseEvent event =
		(
			for observer in m_observers where (IsProperty observer event) do
			(
				(GetProperty observer event) ();
			)
		),

------------------
-- CORE | DEBUG --
------------------

		public function StartTime =
		(
			m_time = Timestamp ();
		),

		public function StopTime =
		(
			format "Execution Time: %s\n" ((Timestamp () - m_time) / 1000.0);
			m_time = undefined;
		),

---------------------------
-- CORE | INITIALIZATION --
---------------------------

		public function Enable =
		(
			m_directory = SysInfo.CurrentDir;

			Callbacks.AddScript #FilePostOpen "Core.RaiseEvent #OnReset" id:#MaxCore;
			Callbacks.AddScript #SystemPostNew "Core.RaiseEvent #OnReset" id:#MaxCore;

			RaiseEvent #OnEnable;
		),

		public function Disable =
		(
			RaiseEvent #OnDisable;

			m_modules = undefined;
			m_observers = undefined;

			Callbacks.RemoveScripts id:#MaxCore;
		)
	)

	Core = maxCore ();
)