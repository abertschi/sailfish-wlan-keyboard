#include <websocketpp/config/asio_no_tls.hpp>
#include <websocketpp/server.hpp>
#include <iostream>

typedef websocketpp::server<websocketpp::config::asio> websocketserver;

using websocketpp::lib::placeholders::_1;
using websocketpp::lib::placeholders::_2;
using websocketpp::lib::bind;

typedef websocketserver::message_ptr message_ptr;

class Server
{
    websocketserver server;

public:
    void start(int port) {
        try {
            std::cout << "init server ..." << std::endl;
            server.init_asio();

            //server.set_message_handler(bind(&on_message, &server, ::_1, ::_2));

            std::cout << "using port " << port << std::endl;
            server.listen(port);

            std::cout << "starting server ..." << port << std::endl;
            server.start_accept();
            server.run();
            std::cout << "server is running ..." << port << std::endl;

        } catch (const std::exception & e) {
            std::cout << e.what() << std::endl;
        } catch (websocketpp::lib::error_code e) {
            std::cout << e.message() << std::endl;
        } catch (...) {
            std::cout << "other exception" << std::endl;
        }
    }

    void stop() {

    }

    char* getIp() {
        return 0;
    }

    int  getPort() {
        return 0;
    }

private:
    void on_message(websocketserver* s, websocketpp::connection_hdl hdl, message_ptr msg) {
        std::cout << "on_message called with hdl: " << hdl.lock().get()
                  << " and message: " << msg->get_payload()
                  << std::endl;
        try {
            s->send(hdl, msg->get_payload(), msg->get_opcode());
        } catch (const websocketpp::lib::error_code& e) {
            std::cout << "Echo failed because: " << e
                      << "(" << e.message() << ")" << std::endl;
        }
    }
};
