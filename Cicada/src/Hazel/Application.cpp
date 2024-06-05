#include "hzpch.h"
#include "Application.h"
#include "Hazel/Log.h" 
#include "glad/glad.h"
namespace Hazel {

	#define BIND_EVENT_FN(x) std::bind(&Application::x,this,std::placeholders::_1)
	Application*  Application::s_Instance = nullptr;
	Application::Application()
	{
		m_Window = std::unique_ptr<Window>(Window::Create());
		m_Window->SetEventCallback(BIND_EVENT_FN(OnEvent));

		s_Instance = this;
		unsigned int id;
		glGenVertexArrays(1,&id);
	}

	Application::~Application()
	{

	}

	void Application::PushLayer(Layer* layer) 
	{
		m_LayerStack.PushLayer(layer);
		layer->OnAttach();

	}
	void Application::PushOverlay(Layer* overlayer) {
		m_LayerStack.PushOverlay(overlayer);
		overlayer->OnAttach();
	}
	

	void Application::OnEvent(Event& e) 
	{
		EventDispatcher dispatcher(e);
		dispatcher.Dispatch<WindowCloseEvent>(BIND_EVENT_FN(OnWindowClose));
	    
		HZ_CORE_TRACE("{0}", e.ToString());
		
		for (auto it = m_LayerStack.end(); it != m_LayerStack.end();)
		{
			(*--it)->OnEvent(e);
			if (e.Handled)
				break;
		}
	}


	void Application::Run()
	{

		while (m_running) {
			glClearColor(1, 0, 1, 1);
			glClear(GL_COLOR_BUFFER_BIT);

			for (Layer* layer : m_LayerStack) {
				layer->OnUpdate();
			}

			m_Window->OnUpdate();
		}
	}         

	bool Application::OnWindowClose(WindowCloseEvent& event) 
	{
		m_running = false;
		return true;
	}
} 