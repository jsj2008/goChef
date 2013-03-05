//
//  SingletonGlobal.h
//  GoChef!
//
//  Created by Pablo Javier Hernandez Oramas on 29/03/2012.
//  Copyright 2012 PJO design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class LoadingViewController, RestaurantClass, TabbarPrincipalViewController, TabbarDomicilioViewController, TabbarRestauranteViewController, TabbarAntesLlegarViewController, TabbarRecogerViewController, DireccionClass, TarjetaClass, CoreLocationClass, JSONparseClass, TipoCocinaClass, UserClass, MensajeClass, CoreDataClass, FacebookClass, SearchRestaurantClass, SearchOfferClass, OrderClass, OrderFoodClass, ImageClass, FoodClass, AESCryptClass;


//# ------------------------------------------------------------------------------------------------------------
//#	Constantes generales
//#
#define _LOADING_DEFAULT_TEXT_              @"Cargando..."

#define _APP_VERSION_                       @"beta v1.0.46"

#define _LIMIT_TO_CHANGE_KM_                10000
    
#define _MI_PEDIDO_GASTOS_ENVIO_            2.0f
#define _MI_PEDIDO_DESCUENTO_               8.0f
#define _MI_PEDIDO_OFERTAS_                 7.25f

#define _NUM_RECORD_BLOCK_INIT_             -1
#define _GET_START_VALUE_                   0
#define _GET_LIMIT_VALUE_REST_DEFAULT_      30
#define _GET_LIMIT_VALUE_OFFERS_DEFAULT_    50
#define _GET_LIMIT_VALUE_ORDERS_DEFAULT_    6
#define _GET_LIMIT_VALUE_                   300

#define _MAP_STANDAR_ZOOM_IN_KM_            5

//# ------------------------------------------------------------------------------------------------------------
//#	Formularios
//#
#define _MAX_FORM_SIZE_NOMBRE_          30
#define _MAX_FORM_SIZE_APELLIDOS_       30
#define _MAX_FORM_SIZE_CORREO_          60
#define _MAX_FORM_SIZE_CLAVE_           10
#define _MAX_FORM_SIZE_UBICACION_       45
#define _MAX_FORM_SIZE_TELEFONO_        20

//# ------------------------------------------------------------------------------------------------------------
//#	Facebook
//#
#define _USER_FACEBOOK_PASSWORD_        @"Manolito66"
#define _FACEBOOK_LINK_POST_            @"http://www.gochef.com/fb/?utm_source=RegaloFB&utm_medium=FB&utm_campaign=Launch"
#define _FACEBOOK_NAME_POST_            @"GoChef!"

//# ------------------------------------------------------------------------------------------------------------
//#	Constantes UMNI
//#
#define _UMNI_ID_PROVIDER_              @"4xJTmc3_umni_es"
#define _HTTP_DOMINIO_SERVICIOS_        @"https://www.gochef.com/services/?"
//#define _HTTP_DOMINIO_SERVICIOS_        @"http://www.umni.es/clientes/gochef/services/?"
#define _UMNI_KEY_CRYPT_                @"B3995E106D304A84"

//# ------------------------------------------------------------------------------------------------------------
//#	Tabbar
//#
#define _TABBAR_INDEX_PRINCIPAL_MI_ACTIVIDAD_       0
#define _TABBAR_INDEX_PRINCIPAL_MI_SACO_            1
#define _TABBAR_INDEX_PRINCIPAL_MI_CUENTA_          2
#define _TABBAR_INDEX_PRINCIPAL_HELP_               12
#define _TABBAR_INDEX_PRINCIPAL_OPCIONES_           13

#define _TABBAR_INDEX_DOMICILIO_BUSCAR_             3
#define _TABBAR_INDEX_DOMICILIO_MI_PEDIDO_          4
#define _TABBAR_INDEX_DOMICILIO_HISTORIAL_          5

#define _TABBAR_INDEX_RESTAURANTE_PEDIR_            6
#define _TABBAR_INDEX_RESTAURANTE_EN_COCINA_        7
#define _TABBAR_INDEX_RESTAURANTE_PAGAR_            8

#define _TABBAR_INDEX_ANTES_LLEGAR_DATOS_           9
#define _TABBAR_INDEX_ANTES_LLEGAR_PEDIR_           10
#define _TABBAR_INDEX_ANTES_LLEGAR_MI_PEDIDO_       11

//# ------------------------------------------------------------------------------------------------------------
//#	Facebook
//#
#define _FACEBOOK_APP_ID_       @"218954414887875"
//#define _FACEBOOK_APP_ID_       @"293541144045161"

//# ------------------------------------------------------------------------------------------------------------
//#	Delays
//#
#define _DELAY_SHOW_TABBAR_VIEW_                0.2f
#define _DELAY_CHANGE_NAVIGATION_CONTROLLER_    0.1f
#define _DELAY_INIT_JSON_PARSE_                 0.3f
#define _DELAY_BACK_NAVBAR_                     0.5f
#define _DELAY_CHECK_NEW_ORDERS_                180.0f

//# ------------------------------------------------------------------------------------------------------------
//#	Base de datos
//#
#define _DB_FILE_NAME_FULL_     @"GoChef.sqlite"
#define _DB_FILE_NAME_          @"GoChef"
#define _DB_FILE_EXTENSION_     @"sqlite"

//# ------------------------------------------------------------------------------------------------------------
//#	Animation
//#
#define _ANIMATION_SHOW_TABBAR_DURATION_                0.5f
#define _ANIMATION_SHOW_GLOBO_DURATION_                 0.4f
#define _ANIMATION_ADD_PLATO_DURATION_                  0.5f
#define _ANIMATION_SHOW_UIVIEW_DIRECCION_DURATION_      0.5f
#define _ANIMATION_SHOW_KEYBOARD_DURATION_              0.3f
#define _ANIMATION_CREDITCARD_EDIT_MODE_DURATION_       0.3f
#define _ANIMATION_MI_ESTADO_ACCUMULATED_DURATION_      0.6f

//# ------------------------------------------------------------------------------------------------------------
//#	Constantes de desarrollo
//#
#define _SHOW_LOG_          TRUE
#define _SHOW_INFO_LOG_     TRUE

//# ------------------------------------------------------------------------------------------------------------
//#	Notificaciones Generales
//#
#define _NOTIFICATION_GO_PRINCIPAL_                 @"_NOTIFICATION_GO_PRINCIPAL_"
#define _NOTIFICATION_GO_MI_ACTIVIDAD_              @"_NOTIFICATION_GO_MI_ACTIVIDAD_"
#define _NOTIFICATION_GO_OPTIONS_                   @"_NOTIFICATION_GO_OPTIONS_"
#define _NOTIFICATION_FACEBOOK_WALL_OK_             @"_NOTIFICATION_FACEBOOK_WALL_OK_"
#define _NOTIFICATION_GO_FACEBOOK_                  @"_NOTIFICATION_GO_FACEBOOK_"
#define _NOTIFICATION_FACEBOOK_PROFILE_SUCCESFUL_   @"_NOTIFICATION_FACEBOOK_PROFILE_SUCCESFUL_"
#define _NOTIFICATION_ENVIAR_COCINA_                @"_NOTIFICATION_ENVIAR_COCINA_"
#define _NOTIFICATION_SEGUIR_PIDIENDO_              @"_NOTIFICATION_SEGUIR_PIDIENDO_"

//# ------------------------------------------------------------------------------------------------------------
//#	Notificaciones JSON
//#
#define _NOTIFICATION_GOOGLE_ADDRESS_PARSE_JSON_            @"_NOTIFICATION_GOOGLE_ADDRESS_PARSE_JSON_"
#define _NOTIFICATION_GOOGLE_ADDRESS_NO_INTERNET_           @"_NOTIFICATION_GOOGLE_ADDRESS_NO_INTERNET_"
#define _NOTIFICATION_GOOGLE_ADDRESS_SUCCESSFUL_            @"_NOTIFICATION_GOOGLE_ADDRESS_SUCCESSFUL_"
#define _NOTIFICATION_GOOGLE_ADDRESS_ERROR_                 @"_NOTIFICATION_GOOGLE_ADDRESS_ERROR_"

#define _NOTIFICATION_TIPOS_COCINA_PARSE_JSON_              @"_NOTIFICATION_TIPOS_COCINA_PARSE_JSON_"
#define _NOTIFICATION_TIPOS_COCINA_NO_INTERNET_             @"_NOTIFICATION_TIPOS_COCINA_NO_INTERNET_"
#define _NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_              @"_NOTIFICATION_TIPOS_COCINA_SUCCESSFUL_"
#define _NOTIFICATION_TIPOS_COCINA_ERROR_                   @"_NOTIFICATION_TIPOS_COCINA_ERROR_"

#define _NOTIFICATION_DIRECCIONES_PARSE_JSON_               @"_NOTIFICATION_DIRECCIONES_PARSE_JSON_"
#define _NOTIFICATION_DIRECCIONES_NO_INTERNET_              @"_NOTIFICATION_DIRECCIONES_NO_INTERNET_"
#define _NOTIFICATION_DIRECCIONES_SUCCESSFUL_               @"_NOTIFICATION_DIRECCIONES_SUCCESSFUL_"
#define _NOTIFICATION_DIRECCIONES_ERROR_                    @"_NOTIFICATION_DIRECCIONES_ERROR_"

#define _NOTIFICATION_RESTAURANTES_PARSE_JSON_              @"_NOTIFICATION_RESTAURANTES_PARSE_JSON_"
#define _NOTIFICATION_RESTAURANTES_NO_INTERNET_             @"_NOTIFICATION_RESTAURANTES_NO_INTERNET_"
#define _NOTIFICATION_RESTAURANTES_SUCCESSFUL_              @"_NOTIFICATION_RESTAURANTES_SUCCESSFUL_"
#define _NOTIFICATION_RESTAURANTES_ERROR_                   @"_NOTIFICATION_RESTAURANTES_ERROR_"

#define _NOTIFICATION_RESTAURANTE_PARSE_JSON_               @"_NOTIFICATION_RESTAURANTE_PARSE_JSON_"
#define _NOTIFICATION_RESTAURANTE_NO_INTERNET_              @"_NOTIFICATION_RESTAURANTE_NO_INTERNET_"
#define _NOTIFICATION_RESTAURANTE_SUCCESSFUL_               @"_NOTIFICATION_RESTAURANTE_SUCCESSFUL_"
#define _NOTIFICATION_RESTAURANTE_ERROR_                    @"_NOTIFICATION_RESTAURANTE_ERROR_"

#define _NOTIFICATION_USER_PARSE_JSON_                      @"_NOTIFICATION_USER_PARSE_JSON_"
#define _NOTIFICATION_USER_NO_INTERNET_                     @"_NOTIFICATION_USER_NO_INTERNET_"
#define _NOTIFICATION_USER_SUCCESSFUL_                      @"_NOTIFICATION_USER_SUCCESSFUL_"
#define _NOTIFICATION_USER_ERROR_                           @"_NOTIFICATION_USER_ERROR_"

#define _NOTIFICATION_SET_MENSAJE_PARSE_JSON_               @"_NOTIFICATION_SET_MENSAJE_PARSE_JSON_"
#define _NOTIFICATION_SET_MENSAJE_NO_INTERNET_              @"_NOTIFICATION_SET_MENSAJE_NO_INTERNET_"
#define _NOTIFICATION_SET_MENSAJE_SUCCESSFUL_               @"_NOTIFICATION_SET_MENSAJE_SUCCESSFUL_"
#define _NOTIFICATION_SET_MENSAJE_ERROR_                    @"_NOTIFICATION_SET_MENSAJE_ERROR_"

#define _NOTIFICATION_SET_USER_PARSE_JSON_                  @"_NOTIFICATION_SET_USER_PARSE_JSON_"
#define _NOTIFICATION_SET_USER_NO_INTERNET_                 @"_NOTIFICATION_SET_USER_NO_INTERNET_"
#define _NOTIFICATION_SET_USER_SUCCESSFUL_                  @"_NOTIFICATION_SET_USER_SUCCESSFUL_"
#define _NOTIFICATION_SET_USER_ERROR_                       @"_NOTIFICATION_SET_USER_ERROR_"

#define _NOTIFICATION_VALIDATE_USER_PARSE_JSON_             @"_NOTIFICATION_VALIDATE_USER_PARSE_JSON_"
#define _NOTIFICATION_VALIDATE_USER_NO_INTERNET_            @"_NOTIFICATION_VALIDATE_USER_NO_INTERNET_"
#define _NOTIFICATION_VALIDATE_USER_SUCCESSFUL_             @"_NOTIFICATION_VALIDATE_USER_SUCCESSFUL_"
#define _NOTIFICATION_VALIDATE_USER_ERROR_                  @"_NOTIFICATION_VALIDATE_USER_ERROR_"
#define _NOTIFICATION_VALIDATE_USER_NO_VALID_               @"_NOTIFICATION_VALIDATE_USER_NO_VALID_"
#define _NOTIFICATION_VALIDATE_USER_BANEADO_                @"_NOTIFICATION_VALIDATE_USER_BANEADO_"

#define _NOTIFICATION_REMEMBER_PASSWORD_JSON_               @"_NOTIFICATION_REMEMBER_PASSWORD_JSON_"
#define _NOTIFICATION_REMEMBER_PASSWORD_NO_INTERNET_        @"_NOTIFICATION_REMEMBER_PASSWORD_NO_INTERNET_"
#define _NOTIFICATION_REMEMBER_PASSWORD_SUCCESSFUL_         @"_NOTIFICATION_REMEMBER_PASSWORD_SUCCESSFUL_"
#define _NOTIFICATION_REMEMBER_PASSWORD_ERROR_              @"_NOTIFICATION_REMEMBER_PASSWORD_ERROR_"

#define _NOTIFICATION_REMOVE_USER_JSON_                     @"_NOTIFICATION_REMOVE_USER_JSON_"
#define _NOTIFICATION_REMOVE_USER_NO_INTERNET_              @"_NOTIFICATION_REMOVE_USER_NO_INTERNET_"
#define _NOTIFICATION_REMOVE_USER_SUCCESSFUL_               @"_NOTIFICATION_REMOVE_USER_SUCCESSFUL_"
#define _NOTIFICATION_REMOVE_USER_ERROR_                    @"_NOTIFICATION_REMOVE_USER_ERROR_"

#define _NOTIFICATION_REMOVE_USER_ADDRESS_JSON_             @"_NOTIFICATION_REMOVE_USER_ADDRESS_JSON_"
#define _NOTIFICATION_REMOVE_USER_ADDRESS_NO_INTERNET_      @"_NOTIFICATION_REMOVE_USER_ADDRESS_NO_INTERNET_"
#define _NOTIFICATION_REMOVE_USER_ADDRESS_SUCCESSFUL_       @"_NOTIFICATION_REMOVE_USER_ADDRESS_SUCCESSFUL_"
#define _NOTIFICATION_REMOVE_USER_ADDRESS_ERROR_            @"_NOTIFICATION_REMOVE_USER_ADDRESS_ERROR_"

#define _NOTIFICATION_VALIDATE_EMAIL_PARSE_JSON_            @"_NOTIFICATION_VALIDATE_EMAIL_PARSE_JSON_"
#define _NOTIFICATION_VALIDATE_EMAIL_NO_INTERNET_           @"_NOTIFICATION_VALIDATE_EMAIL_NO_INTERNET_"
#define _NOTIFICATION_VALIDATE_EMAIL_SUCCESSFUL_            @"_NOTIFICATION_VALIDATE_EMAIL_SUCCESSFUL_"
#define _NOTIFICATION_VALIDATE_EMAIL_ERROR_                 @"_NOTIFICATION_VALIDATE_EMAIL_ERROR_"
#define _NOTIFICATION_VALIDATE_EMAIL_EXISTE_OK_             @"_NOTIFICATION_VALIDATE_EMAIL_EXISTE_OK_"
#define _NOTIFICATION_VALIDATE_EMAIL_EXISTE_KO_             @"_NOTIFICATION_VALIDATE_EMAIL_EXISTE_KO_"
#define _NOTIFICATION_VALIDATE_EMAIL_BANEADO_               @"_NOTIFICATION_VALIDATE_EMAIL_BANEADO_"

#define _NOTIFICATION_FOOD_PARSE_JSON_                      @"_NOTIFICATION_FOOD_PARSE_JSON_"
#define _NOTIFICATION_FOOD_NO_INTERNET_                     @"_NOTIFICATION_FOOD_NO_INTERNET_"
#define _NOTIFICATION_FOOD_SUCCESSFUL_                      @"_NOTIFICATION_FOOD_SUCCESSFUL_"
#define _NOTIFICATION_FOOD_ERROR_                           @"_NOTIFICATION_FOOD_ERROR_"

#define _NOTIFICATION_FOOD_CATEGORIES_PARSE_JSON_           @"_NOTIFICATION_FOOD_CATEGORIES_PARSE_JSON_"
#define _NOTIFICATION_FOOD_CATEGORIES_NO_INTERNET_          @"_NOTIFICATION_FOOD_CATEGORIES_NO_INTERNET_"
#define _NOTIFICATION_FOOD_CATEGORIES_SUCCESSFUL_           @"_NOTIFICATION_FOOD_CATEGORIES_SUCCESSFUL_"
#define _NOTIFICATION_FOOD_CATEGORIES_ERROR_                @"_NOTIFICATION_FOOD_CATEGORIES_ERROR_"

#define _NOTIFICATION_DAILY_MENU_PARSE_JSON_                @"_NOTIFICATION_DAILY_MENU_PARSE_JSON_"
#define _NOTIFICATION_DAILY_MENU_NO_INTERNET_               @"_NOTIFICATION_DAILY_MENU_NO_INTERNET_"
#define _NOTIFICATION_DAILY_MENU_SUCCESSFUL_                @"_NOTIFICATION_DAILY_MENU_SUCCESSFUL_"
#define _NOTIFICATION_DAILY_MENU_ERROR_                     @"_NOTIFICATION_DAILY_MENU_ERROR_"

#define _NOTIFICATION_DAILY_MENU_CATEGORIES_PARSE_JSON_     @"_NOTIFICATION_DAILY_MENU_CATEGORIES_PARSE_JSON_"
#define _NOTIFICATION_DAILY_MENU_CATEGORIES_NO_INTERNET_    @"_NOTIFICATION_DAILY_MENU_CATEGORIES_NO_INTERNET_"
#define _NOTIFICATION_DAILY_MENU_CATEGORIES_SUCCESSFUL_     @"_NOTIFICATION_DAILY_MENU_CATEGORIES_SUCCESSFUL_"
#define _NOTIFICATION_DAILY_MENU_CATEGORIES_ERROR_          @"_NOTIFICATION_DAILY_MENU_CATEGORIES_ERROR_"

#define _NOTIFICATION_DAILY_MENU_FOOD_PARSE_JSON_           @"_NOTIFICATION_DAILY_MENU_FOOD_PARSE_JSON_"
#define _NOTIFICATION_DAILY_MENU_FOOD_NO_INTERNET_          @"_NOTIFICATION_DAILY_MENU_FOOD_NO_INTERNET_"
#define _NOTIFICATION_DAILY_MENU_FOOD_SUCCESSFUL_           @"_NOTIFICATION_DAILY_MENU_FOOD_SUCCESSFUL_"
#define _NOTIFICATION_DAILY_MENU_FOOD_ERROR_                @"_NOTIFICATION_DAILY_MENU_FOOD_ERROR_"

#define _NOTIFICATION_OFFERS_PARSE_JSON_                    @"_NOTIFICATION_OFFERS_PARSE_JSON_"
#define _NOTIFICATION_OFFERS_NO_INTERNET_                   @"_NOTIFICATION_OFFERS_NO_INTERNET_"
#define _NOTIFICATION_OFFERS_SUCCESSFUL_                    @"_NOTIFICATION_OFFERS_SUCCESSFUL_"
#define _NOTIFICATION_OFFERS_ERROR_                         @"_NOTIFICATION_OFFERS_ERROR_"

#define _NOTIFICATION_ORDERS_PARSE_JSON_                    @"_NOTIFICATION_ORDERS_PARSE_JSON_"
#define _NOTIFICATION_ORDERSDEVOLUTIONS_PARSE_JSON_         @"_NOTIFICATION_ORDERSDEVOLUTIONS_PARSE_JSON_"

#define _NOTIFICATION_ORDERS_NO_INTERNET_                   @"_NOTIFICATION_ORDERS_NO_INTERNET_"
#define _NOTIFICATION_ORDERS_SUCCESSFUL_                    @"_NOTIFICATION_ORDERS_SUCCESSFUL_"
#define _NOTIFICATION_ORDERS_ERROR_                         @"_NOTIFICATION_ORDERS_ERROR_"

#define _NOTIFICATION_ORDER_FOOD_PARSE_JSON_                @"_NOTIFICATION_ORDER_FOOD_PARSE_JSON_"
#define _NOTIFICATION_ORDER_FOOD_NO_INTERNET_               @"_NOTIFICATION_ORDER_FOOD_NO_INTERNET_"
#define _NOTIFICATION_ORDER_FOOD_SUCCESSFUL_                @"_NOTIFICATION_ORDER_FOOD_SUCCESSFUL_"
#define _NOTIFICATION_ORDER_FOOD_ERROR_                     @"_NOTIFICATION_ORDER_FOOD_ERROR_"

#define _NOTIFICATION_SET_ADDRESS_PARSE_JSON_               @"_NOTIFICATION_SET_ADDRESS_PARSE_JSON_"
#define _NOTIFICATION_SET_ADDRESS_NO_INTERNET_              @"_NOTIFICATION_SET_ADDRESS_NO_INTERNET_"
#define _NOTIFICATION_SET_ADDRESS_SUCCESSFUL_               @"_NOTIFICATION_SET_ADDRESS_SUCCESSFUL_"
#define _NOTIFICATION_SET_ADDRESS_ERROR_                    @"_NOTIFICATION_SET_ADDRESS_ERROR_"

#define _NOTIFICATION_UPDATE_ADDRESS_PARSE_JSON_            @"_NOTIFICATION_UPDATE_ADDRESS_PARSE_JSON_"
#define _NOTIFICATION_UPDATE_ADDRESS_NO_INTERNET_           @"_NOTIFICATION_UPDATE_ADDRESS_NO_INTERNET_"
#define _NOTIFICATION_UPDATE_ADDRESS_SUCCESSFUL_            @"_NOTIFICATION_UPDATE_ADDRESS_SUCCESSFUL_"
#define _NOTIFICATION_UPDATE_ADDRESS_ERROR_                 @"_NOTIFICATION_UPDATE_ADDRESS_ERROR_"

#define _NOTIFICATION_REMOVE_ADDRESS_PARSE_JSON_            @"_NOTIFICATION_REMOVE_ADDRESS_PARSE_JSON_"
#define _NOTIFICATION_REMOVE_ADDRESS_NO_INTERNET_           @"_NOTIFICATION_REMOVE_ADDRESS_NO_INTERNET_"
#define _NOTIFICATION_REMOVE_ADDRESS_SUCCESSFUL_            @"_NOTIFICATION_REMOVE_ADDRESS_SUCCESSFUL_"
#define _NOTIFICATION_REMOVE_ADDRESS_ERROR_                 @"_NOTIFICATION_REMOVE_ADDRESS_ERROR_"

#define _NOTIFICATION_SET_ORDERS_PARSE_JSON_                @"_NOTIFICATION_SET_ORDERS_PARSE_JSON_"
#define _NOTIFICATION_SET_ORDERS_NO_INTERNET_               @"_NOTIFICATION_SET_ORDERS_NO_INTERNET_"
#define _NOTIFICATION_SET_ORDERS_SUCCESSFUL_                @"_NOTIFICATION_SET_ORDERS_SUCCESSFUL_"
#define _NOTIFICATION_SET_ORDERS_ERROR_                     @"_NOTIFICATION_SET_ORDERS_ERROR_"
#define _NOTIFICATION_UPDATE_ORDER_STATUS_ERROR_            @"_NOTIFICATION_UPDATE_ORDER_STATUS_ERROR_"
#define _NOTIFICATION_UPDATE_ORDER_STATUS_SUCCESSFUL_       @"_NOTIFICATION_UPDATE_ORDER_STATUS_SUCCESSFUL_"

#define _NOTIFICATION_SET_ORDER_FOOD_PARSE_JSON_            @"_NOTIFICATION_SET_ORDER_FOOD_PARSE_JSON_"
#define _NOTIFICATION_SET_ORDER_FOOD_NO_INTERNET_           @"_NOTIFICATION_SET_ORDER_FOOD_NO_INTERNET_"
#define _NOTIFICATION_SET_ORDER_FOOD_SUCCESSFUL_            @"_NOTIFICATION_SET_ORDER_FOOD_SUCCESSFUL_"
#define _NOTIFICATIONSET__ORDER_FOOD_ERROR_                 @"_NOTIFICATIONSET__ORDER_FOOD_ERROR_"

#define _NOTIFICATION_SEND_ORDER_TICKET_PARSE_JSON_         @"_NOTIFICATION_SEND_ORDER_TICKET_PARSE_JSON_"
#define _NOTIFICATION_SEND_ORDER_TICKET_NO_INTERNET_        @"_NOTIFICATION_SEND_ORDER_TICKET_NO_INTERNET_"
#define _NOTIFICATION_SEND_ORDER_TICKET_SUCCESSFUL_         @"_NOTIFICATION_SEND_ORDER_TICKET_SUCCESSFUL_"
#define _NOTIFICATION_SEND_ORDER_TICKET_ERROR_              @"_NOTIFICATION_SEND_ORDER_TICKET_ERROR_"

#define _NOTIFICATION_FAVORITES_STARS_PARSE_JSON_           @"_NOTIFICATION_FAVORITES_STARS_PARSE_JSON_"
#define _NOTIFICATION_FAVORITES_STARS_NO_INTERNET_          @"_NOTIFICATION_FAVORITES_STARS_NO_INTERNET_"
#define _NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_           @"_NOTIFICATION_FAVORITES_STARS_SUCCESSFUL_"
#define _NOTIFICATION_FAVORITES_STARS_ERROR_                @"_NOTIFICATION_FAVORITES_STARS_ERROR_"

#define _NOTIFICATION_VALIDATE_TABLE_NUMBER_PARSE_JSON_     @"_NOTIFICATION_VALIDATE_TABLE_NUMBER_PARSE_JSON_"
#define _NOTIFICATION_VALIDATE_TABLE_NUMBER_NO_INTERNET_    @"_NOTIFICATION_VALIDATE_TABLE_NUMBER_NO_INTERNET_"
#define _NOTIFICATION_VALIDATE_TABLE_NUMBER_SUCCESSFUL_     @"_NOTIFICATION_VALIDATE_TABLE_NUMBER_SUCCESSFUL_"
#define _NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_          @"_NOTIFICATION_VALIDATE_TABLE_NUMBER_ERROR_"
#define _NOTIFICATION_VALIDATE_TABLE_NUMBER_BUSY_           @"_NOTIFICATION_VALIDATE_TABLE_NUMBER_BUSY_"

#define _NOTIFICATION_CHECK_OUT_PARSE_JSON_                 @"_NOTIFICATION_CHECK_OUT_PARSE_JSON_"
#define _NOTIFICATION_CHECK_OUT_NO_INTERNET_                @"_NOTIFICATION_CHECK_OUT_NO_INTERNET_"
#define _NOTIFICATION_CHECK_OUT_SUCCESSFUL_                 @"_NOTIFICATION_CHECK_OUT_SUCCESSFUL_"
#define _NOTIFICATION_CHECK_OUT_ERROR_                      @"_NOTIFICATION_CHECK_OUT_ERROR_"

#define _NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_        @"_NOTIFICATION_HIDE_RESTAURANT_TABBAR_BUTTON_"
#define _NOTIFICATION_SHOW_RESTAURANT_TABBAR_BUTTON_        @"_NOTIFICATION_SHOW_RESTAURANT_TABBAR_BUTTON_"

#define _NOTIFICATION_IMAGE_PARSE_JSON_                     @"_NOTIFICATION_IMAGE_PARSE_JSON_"
#define _NOTIFICATION_IMAGE_NO_INTERNET_                    @"_NOTIFICATION_IMAGE_NO_INTERNET_"
#define _NOTIFICATION_IMAGE_SUCCESSFUL_                     @"_NOTIFICATION_IMAGE_SUCCESSFUL_"
#define _NOTIFICATION_IMAGE_ERROR_                          @"_NOTIFICATION_IMAGE_ERROR_"

#define _NOTIFICATION_USER_MEMBERSHIP_PARSE_JSON_           @"_NOTIFICATION_USER_MEMBERSHIP_PARSE_JSON_"
#define _NOTIFICATION_USER_MEMBERSHIP_NO_INTERNET_          @"_NOTIFICATION_USER_MEMBERSHIP_NO_INTERNET_"
#define _NOTIFICATION_USER_MEMBERSHIP_SUCCESSFUL_           @"_NOTIFICATION_USER_MEMBERSHIP_SUCCESSFUL_"
#define _NOTIFICATION_USER_MEMBERSHIP_ERROR_                @"_NOTIFICATION_USER_MEMBERSHIP_ERROR_"

#define _NOTIFICATION_GET_FACEBOOK_OFFERS_PARSE_JSON_       @"_NOTIFICATION_GET_FACEBOOK_OFFERS_PARSE_JSON_"
#define _NOTIFICATION_GET_FACEBOOK_OFFERS_NO_INTERNET_      @"_NOTIFICATION_GET_FACEBOOK_OFFERS_NO_INTERNET_"
#define _NOTIFICATION_GET_FACEBOOK_OFFERS_SUCCESSFUL_       @"_NOTIFICATION_GET_FACEBOOK_OFFERS_SUCCESSFUL_"
#define _NOTIFICATION_GET_FACEBOOK_OFFERS_ERROR_            @"_NOTIFICATION_GET_FACEBOOK_OFFERS_ERROR_"

#define _NOTIFICATION_SET_FACEBOOK_OFFERS_PARSE_JSON_       @"_NOTIFICATION_SET_FACEBOOK_OFFERS_PARSE_JSON_"
#define _NOTIFICATION_SET_FACEBOOK_OFFERS_NO_INTERNET_      @"_NOTIFICATION_SET_FACEBOOK_OFFERS_NO_INTERNET_"
#define _NOTIFICATION_SET_FACEBOOK_OFFERS_SUCCESSFUL_       @"_NOTIFICATION_SET_FACEBOOK_OFFERS_SUCCESSFUL_"
#define _NOTIFICATION_SET_FACEBOOK_OFFERS_ERROR_            @"_NOTIFICATION_SET_FACEBOOK_OFFERS_ERROR_"

#define _NOTIFICATION_VALIDATE_ADDRESS_PARSE_JSON_          @"_NOTIFICATION_VALIDATE_ADDRESS_PARSE_JSON_"
#define _NOTIFICATION_VALIDATE_ADDRESS_NO_INTERNET_         @"_NOTIFICATION_VALIDATE_ADDRESS_NO_INTERNET_"
#define _NOTIFICATION_VALIDATE_ADDRESS_SUCCESSFUL_          @"_NOTIFICATION_VALIDATE_ADDRESS_SUCCESSFUL_"
#define _NOTIFICATION_VALIDATE_ADDRESS_ERROR_               @"_NOTIFICATION_VALIDATE_ADDRESS_ERROR_"
#define _NOTIFICATION_VALIDATE_ADDRESS_NO_VALID_            @"_NOTIFICATION_VALIDATE_ADDRESS_NO_VALID_"

#define _NOTIFICATION_MEMBERSHIPVALIDATE_JSON_              @"_NOTIFICATION_MEMBERSHIPVALIDATE_JSON_"
#define _NOTIFICATION_MEMBERSHIPVALIDATE_NO_INTERNET_       @"_NOTIFICATION_MEMBERSHIPVALIDATE_NO_INTERNET_"
#define _NOTIFICATION_MEMBERSHIPVALIDATE_SUCCESSFUL_        @"_NOTIFICATION_MEMBERSHIPVALIDATE_SUCCESSFUL_"
#define _NOTIFICATION_MEMBERSHIPVALIDATE_NO_ALLOWED_        @"_NOTIFICATION_MEMBERSHIPVALIDATE_NO_ALLOWED_"
#define _NOTIFICATION_MEMBERSHIPVALIDATE_ERROR_             @"_NOTIFICATION_MEMBERSHIPVALIDATE_ERROR_"

#define _NOTIFICATION_EN_MESA_ACTIVE_JSON_                  @"_NOTIFICATION_EN_MESA_ACTIVE_JSON_"
#define _NOTIFICATION_EN_MESA_ACTIVE_NO_INTERNET_           @"_NOTIFICATION_EN_MESA_ACTIVE_NO_INTERNET_"
#define _NOTIFICATION_EN_MESA_ACTIVE_SUCCESSFUL_            @"_NOTIFICATION_EN_MESA_ACTIVE_SUCCESSFUL_"
#define _NOTIFICATION_EN_MESA_ACTIVE_ERROR_                 @"_NOTIFICATION_EN_MESA_ACTIVE_ERROR_"

#define _NOTIFICATION_NUM_NEW_ORDERS_JSON_                  @"_NOTIFICATION_NUM_NEW_ORDERS_JSON_"
#define _NOTIFICATION_NUM_NEW_ORDERS_NO_INTERNET_           @"_NOTIFICATION_NUM_NEW_ORDERS_NO_INTERNET_"
#define _NOTIFICATION_NUM_NEW_ORDERS_SUCCESSFUL_            @"_NOTIFICATION_NUM_NEW_ORDERS_SUCCESSFUL_"
#define _NOTIFICATION_NUM_NEW_ORDERS_ERROR_                 @"_NOTIFICATION_NUM_NEW_ORDERS_ERROR_"

#define _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_JSON_         @"_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_JSON_"
#define _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_NO_INTERNET_  @"_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_NO_INTERNET_"
#define _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_SUCCESSFUL_   @"_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_SUCCESSFUL_"
#define _NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_ERROR_        @"_NOTIFICATION_FOOD_OPTIONS_OBLIGATORY_ERROR_"

#define _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_JSON_              @"_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_JSON_"
#define _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_NO_INTERNET_       @"_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_NO_INTERNET_"
#define _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_SUCCESSFUL_        @"_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_SUCCESSFUL_"
#define _NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_ERROR_             @"_NOTIFICATION_FOOD_OPTIONS_NO_OBLIGATORY_ERROR_"

#define _NOTIFICATION_NUM_REGRISTROS_JSON_                  @"_NOTIFICATION_NUM_REGRISTROS_JSON_"
#define _NOTIFICATION_NUM_REGRISTROS_NO_INTERNET_           @"_NOTIFICATION_NUM_REGRISTROS_NO_INTERNET_"
#define _NOTIFICATION_NUM_REGRISTROS_SUCCESSFUL_            @"_NOTIFICATION_NUM_REGRISTROS_SUCCESSFUL_"
#define _NOTIFICATION_NUM_REGRISTROS_ERROR_                 @"_NOTIFICATION_NUM_REGRISTROS_ERROR_"

#define _NOTIFICATION_SEND_ORDER_REPORT_JSON_               @"_NOTIFICATION_SEND_ORDER_REPORT_JSON_"
#define _NOTIFICATION_SEND_ORDER_REPORT_NO_INTERNET_        @"_NOTIFICATION_SEND_ORDER_REPORT_NO_INTERNET_"
#define _NOTIFICATION_SEND_ORDER_REPORT_SUCCESSFUL_         @"_NOTIFICATION_SEND_ORDER_REPORT_SUCCESSFUL_"
#define _NOTIFICATION_SEND_ORDER_REPORT_ERROR_              @"_NOTIFICATION_SEND_ORDER_REPORT_ERROR_"

//# ------------------------------------------------------------------------------------------------------------
//#	Textos 
//#
#define _COMBO_TIPOS_COCINA_                    @"Tipos de Comida"

#define _COMBO_FILTRO_RESTAURATES_              @"Filtros"
#define _COMBO_FILTRO_RESTAURATES_FAVORITOS_    @"Favoritos"
#define _COMBO_FILTRO_RESTAURATES_HISTORICO_    @"Histórico"

#define _COMBO_DIRECCION_SELECCIONAR_           @"Seleccione localización"
#define _COMBO_DIRECCION_LOCALIZACION_ACTUAL_   @"Localización actual"

#define _COMBO_SEXO_HOMBRE_                     @"Hombre"
#define _COMBO_SEXO_MUJER_                      @"Mujer"

#define _COMBO_TIPO_CARTA_CARTA_                @"Carta"
#define _COMBO_TIPO_CARTA_MENU_                 @"Menú"

#define _PEDIDO_MAS_INGREDIENTES_TEXT_           @"¿Más ingredientes?"

#define _ESTADO_ORO_                            @"Oro"
#define _ESTADO_PLATA_                          @"Plata"
#define _ESTADO_PLATINO_                        @"Platino"

#define _CREDITCARD_VISA_TEXT_                  @"visa"
#define _CREDITCARD_MASTERCARD_TEXT_            @"mastercard"

//# ------------------------------------------------------------------------------------------------------------
//#	Null values
//#
#define _ID_DIRECCION_LOCALIZACION_ACTUAL_          0
#define _ID_DIRECCION_NEW_LOCALIZACION_ACTUAL_      -1
#define _ID_USER_NO_REGISTRADO_                     -1
#define _ID_OFFER_NO_SELECTED_                      -1
#define _ID_ADDRESS_NO_SELECTED_                    -5
#define _ID_CREDITCARD_NO_SELECTED_                 -5
#define _ID_NEW_ADDRESS_                            -6
#define _ID_FOOD_NO_SELECCIONADA_                   -1
#define _ID_FOOD_NO_GROUP_                          -1
#define _ID_USER_MEMBERSHIP_NO_VALUE_               -1
#define _ID_FACEBOOK_OFFER_NO_SELECCIONADA_         0
#define _ID_RESTAURANT_NO_SELECTED_                 -1
#define _ID_ORDER_NO_VALUE_                         -1
#define _ID_OFFER_NO_DESCUENTO_VALUE_               -1

#define _CVV_CREDIT_CARD_NULL                       @""

//# ------------------------------------------------------------------------------------------------------------
//#	Valoración
//#
#define _SHORT_INFO_VALORACION_0_IMG_FNAME_         @"restaurante_valoracion_estrella_0.png"
#define _SHORT_INFO_VALORACION_50_IMG_FNAME_        @"restaurante_valoracion_estrella_50.png"
#define _SHORT_INFO_VALORACION_100_IMG_FNAME_       @"restaurante_valoracion_estrella_all.png"

//# ------------------------------------------------------------------------------------------------------------
//#	Textos Mensages de sistema
//#
#define _ALERT_TITLE_NO_REGISTRADO_             @"Usuario no registrado"
#define _ALERT_MSG_NO_REGISTRADO_               @"Para realizar esta operación debes estar registrado."

#define _ALERT_TITLE_NO_REGISTRADO_MI_SACO_     @"Usuario no registrado"
#define _ALERT_MSG_NO_REGISTRADO_MI_SACO_       @"Para acceder a todas las ofertas de Mi Saco debes estar registrado."

#define _ALERT_TITLE_NO_CONNECTION_             @"No hay conexión a la red"
#define _ALERT_MSG_NO_CONNECTION_               @"Compruebe su configuración de WiFi, 3G o 'modo de avión'."

#define _ALERT_TITLE_ERROR_                     @"Error"
#define _ALERT_MSG_ERROR_                       @"Lo sentimos, ha ocurrido un error, por favor inténtelo nuevamente."

#define _ALERT_TITLE_NO_OFFERS_                 @"Información"
#define _ALERT_MSG_NO_OFFERS_                   @"No tiene ofertas para el restaurante seleccionado."

#define _ALERT_TITLE_NO_MORE_OFFERS_            @"Error"
#define _ALERT_MSG_NO_MORE_OFFERS_              @"Ya ha utilizado una oferta, las ofertas no son acumulables."

#define _ALERT_TITLE_UPDATE_USER_               @"Información"
#define _ALERT_MSG_UPDATE_USER_                 @"Los datos se han actualizado correctamente."

#define _ALERT_TITLE_REGISTRO_USER_             @"Información"
#define _ALERT_MSG_REGISTRO_USER_               @"El usuario se ha dado de alta correctamente."

#define _ALERT_TITLE_FACEBOOK_                  @"Información"
#define _ALERT_MSG_FACEBOOK_                    @"Gracias por compartir en facebook."

#define _ALERT_TITLE_CONFIRMADO_                @"Información"
#define _ALERT_MSG_CONFIRMADO_                  @"Su pedido se ha enviado al restaurante. Consulte el menú 'Mi Actividad' para verificar el estado del pedido."
#define _ALERT_MSG_CONFIRMADO_Y_PAGADO_CON_TARJETA_ @"Su pedido se ha enviado al restaurante. Consulte el menú 'Mi Actividad' para verificar el estado del pedido."

#define _ALERT_TITLE_PEDIR_CUENTA_              @"Información"
#define _ALERT_MSG_PEDIR_CUENTA_                @"Su solicitud ha sido enviada. Pronto le llevarán la cuenta a su mesa."

#define _ALERT_TITLE_PAGAR_TARJETA_             @"Información"
#define _ALERT_MSG_PAGAR_TARJETA_               @"Su pago se ha enviado al restaurante. Consulte el menú 'Mi Actividad' para verificar que se ha efectuado correctamente."

#define _ALERT_TITLE_SEND_TICKET_               @"Información"
#define _ALERT_MSG_SEND_TICKET_                 @"Le hemos enviado una copia del ticket a su correo."

#define _ALERT_TITLE_RESERVA_                   @"Información"
#define _ALERT_MSG_RESERVA_                     @"Su reserva se ha enviado al restaurante. Consulte el menú 'Mi Actividad' para verificar el estado."

#define _ALERT_TITLE_NUM_TABLE_                 @"Numero de mesa no disponible"
#define _ALERT_MSG_NUM_TABLE_                   @"El número de mesa que ha introducido no es válido para el restaurante seleccionado."

#define _ALERT_TITLE_FACEBOOK_OFFER_            @"Información"
#define _ALERT_MSG_FACEBOOK_OFFER_              @"Ya ha utilizado esta oferta."

#define _ALERT_TITLE_UMNI_ERROR_                               @"Error"
#define _ALERT_TITLE_TPV_                                      @"Pago con tarjeta"
#define _ALERT_MSG_UMNI_ERROR_default_                         @"Lo sentimos, ha ocurrido un error, por favor inténtelo nuevamente."
#define _ALERT_MSG_UMNI_ERROR_validateLogin_                   @"Lo sentimos, el usuario o contraseña es incorrecto, verifique la información e inténtelo nuevamente."
#define _ALERT_MSG_UMNI_ERROR_rememberPassword_                @"Lo sentimos, ha ocurrido un error, por favor inténtelo nuevamente."
#define _ALERT_MSG_UMNI_ERROR_sendOrderticket_                 @"Lo sentimos, ha ocurrido un error al enviar el pedido, por favor inténtelo nuevamente."
#define _ALERT_MSG_UMNI_ERROR_validateTablenumber_             @"Lo sentimos, este número de mesa no existe en este restaurante, verifique la información e inténtelo nuevamente."
#define _ALERT_MSG_UMNI_ERROR_setOrder_                        @"Lo sentimos, ha ocurrido un error al intentar enviar su pedido, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_setOrderfood_                    @"Lo sentimos, ha ocurrido un error al intentar enviar su pedido, por favor inténtelo nuevamente."
#define _ALERT_MSG_UMNI_ERROR_setUsermembership_               @"Lo sentimos, ha ocurrido un error al intentar crear su usuario, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_setUseraddress_                  @"Lo sentimos, ha ocurrido un error al intentar crear una nueva dirección, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_setCreditcard_                   @"Lo sentimos, ha ocurrido un error al intentar crear una nueva tarjeta de crédito, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_setSuggestionsproblems_          @"Lo sentimos, ha ocurrido un error al intentar enviar el formulario, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_setRestaurantStarsfavorites_     @"Lo sentimos, ha ocurrido un error al intentar guardar los datos, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_deleteUser_                      @"Lo sentimos, ha ocurrido un error al intentar eliminar este usuario, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_deleteUserAddress_               @"Lo sentimos, ha ocurrido un error al intentar eliminar su tarjeta de crédito, por favor inténtelo nuevamente pasados unos minutos."
#define _ALERT_MSG_UMNI_ERROR_getRestaurantpostalcode_         @"Lo sentimos, el servicio a domicilio del restaurante seleccionado no esta disponible en su zona."
#define _ALERT_MSG_UMNI_ERROR_tipo_pedido_disable_             @"El restaurante que has seleccionado está cerrado. Por favor, inténtalo más tarde o selecciona otro restaurante."

#define _ALERT_MSG_UMIN_CANCELATION_ERROR_                      @"Su pedido ha sido cancelado por el restaurante %@"
#define _ALERT_MSG_UMIN_CANCELATION_OK_                         @"Su pedido ha sido cancelado por el restaurante %@"

#define _WEEK_DAYS_ [NSArray arrayWithObjects:@"domingo",@"lunes",@"martes",@"miercoles",@"jueves",@"viernes",@"sabado", nil]


//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del EstadoType
//#
typedef enum 
{
    TET_oro     = 0,
    TET_platino = 1
}
typeEstadoType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del MensajeType
//#
typedef enum 
{
    TMT_sugerencia = 0,
    TMT_problema   = 1
}
typeMensajeType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del SexoType
//#
typedef enum 
{
    TST_hombre = 0,
    TST_mujer  = 1
}
typeSexoType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del RegisterType
//#
typedef enum 
{
    TRT_normal   = 0,
    TRT_facebook = 1
}
typeRegisterType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeResultOrder
//#
typedef enum 
{
    TRO_distancia  = 0,
    TRO_ofertas    = 1,
    TRO_descuentos = 2
}
typeResultOrder;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeOfferOrder
//#
typedef enum 
{
    TOO_fecha     = 0,
    TOO_distancia = 1
}
typeOfferOrder;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeFilterRestaurant
//#
typedef enum 
{
    TFR_todos     = 0,
    TFR_favoritos = 1,
    TFR_historico = 2
}
typeFilterRestaurant;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeOfferFilter
//#
typedef enum 
{
    TOF_todos     = 0,
    TOF_favoritos = 1,
    TOF_hoy       = 2
}
typeOfferFilter;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeRestaurantService
//#
typedef enum 
{
    TRS_no_incluido = 0,
    TRS_si_incluido = 1,
    TRS_no_activo   = 2
}
typeRestaurantService;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeOrderStatus
//#
typedef enum 
{
    TOS_pagado_con_tarjeta               = 0,
    TOS_confirmado_y_pagado_con_tarjeta  = 1,
    TOS_confirmado_y_pagado_con_efectivo = 2,
    TOS_confirmado                       = 3,
    TOS_pagado_con_efectivo              = 4,
    TOS_pendiente_de_confirmar_y_pago    = 5,
    TOS_confirmado_y_pendiente_de_pago   = 6,
    TOS_cobro_fallido                    = 7,
    TOS_devolucion_efectuada             = 8,
    TOS_devolucion_fallida               = 9,
    TOS_devolucion_pendiente             = 10,
    TOS_cancelado                        = 11
}
typeOrderStatus;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeOrderType
//#
typedef enum
{
    TOT_pedido_a_domicilio                = 1,
    TOT_pedido_para_recoger               = 2,
    TOT_pedido_antes_de_ir_al_restaurante = 3,
    TOT_pedido_en_el_restaurante          = 4,
    TOT_reserva                           = 5
}
typeOrderType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeOrderActive
//#
typedef enum 
{
    TOA_cerrado = 0,
    TOA_abierto = 1
}
typeOrderActive;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeCheckOutType
//#
typedef enum 
{
    TCO_pago_con_tarjeta    = 0,
    TCO_solicitud_de_cuenta = 1
}
typeCheckOutType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeImageType
//#
typedef enum 
{
    TIT_restaurants = 1,
    TIT_offers      = 2,
    TIT_foods       = 3
}
typeImageType;

//# ------------------------------------------------------------------------------------------------------------
//#	Typedef del typeOfferType
//#
typedef enum 
{
    TOT_descuento_sobre_carta  = 0,
    TOT_regalo_plato_categoria = 1,
    TOT_2x1_en_categoria       = 2,
    TOT_regalo_plato           = 3
}
typeOfferType;


@interface SingletonGlobal : NSObject {
    
    NSInteger _NSI_NavController_index;
    NSInteger _NSI_last_Id_DDBB;
    NSInteger _NSI_num_new_order;
    NSInteger _NSI_numRecordBlock;
    
    NSInteger _NSI_blocksize_restaurants;
    NSInteger _NSI_blocksize_offers;
    NSInteger _NSI_blocksize_orders;
    
    NSString *_NSS_deviceToken;
    NSString *_NSS_msg_error;
    
    BOOL _B_valueFavoritos;
    NSInteger _NSI_value;
    
    FacebookClass  *_FC_facebook;
    MensajeClass   *_MC_mensaje;
    TarjetaClass   *_TC_creditcard;
    ImageClass     *_IC_image;
    DireccionClass *_DC_direccion;
    
    AESCryptClass *_AES_crypt;
    
    BOOL _B_usuario_registrado;
    BOOL _B_realizando_pedido;
    BOOL _B_pedido_confirmado;
    BOOL _B_come_from_historial;
    BOOL _B_come_from_mi_saco;
    BOOL _B_origen_mi_saco;
    BOOL _B_guardar_usuario;
    BOOL _B_pedido_en_cocina;
    BOOL _B_options;
    BOOL _B_datos_introducidos;
    BOOL _B_cargar_imagenes;
    BOOL _B_come_from_condiciones_legales;
    BOOL _B_data_historico_updated;
    BOOL _B_registro_facebook;
    BOOL _B_restaurante_con_fidelizacion;
    BOOL _B_login_from_reserva;
    BOOL _B_active_en_mesa;
    BOOL _B_come_from_instrucciones;
    BOOL _B_change_password;
    
    BOOL _B_UMNI_getRestaurants_active;
    BOOL _B_UMNI_getOrders_active;
    BOOL _B_UMNI_getOffers_active;
    
    SearchRestaurantClass *_SRC_search;
    SearchOfferClass *_SOC_search;
    
    UserClass *_UC_user;
    FoodClass *_FC_food;
    
    OrderClass *_OC_order;
    OrderClass *_OC_order_en_cocina;
    OrderFoodClass *_OFC_order_food;
    
    NSMutableArray *_NSMA_tabbar_viewcontroller;
    NSInteger _NSI_tabbar_index;
    
    LoadingViewController *_LVC_loading;
    
    TabbarPrincipalViewController   *_TPVC_principal;
    TabbarDomicilioViewController   *_TPVC_domicilio;
    TabbarRestauranteViewController *_TPVC_restaurante;
    TabbarAntesLlegarViewController *_TPVC_antesllegar;
    TabbarRecogerViewController     *_TPVC_recoger;
    
    CoreLocationClass *_CLC_location;
    CoreDataClass *_CDC_coreData;
    JSONparseClass *_JPC_json;
    
    NSMutableArray *_NSMA_restaurants;
    NSMutableArray *_NSMA_direcciones;
    NSMutableArray *_NSMA_tarjetas;
    NSMutableArray *_NSMA_orders;
    NSMutableArray *_NSMA_mi_saco;
    NSMutableArray *_NSMA_tipos_cocina;
}

@property (nonatomic, readwrite) NSInteger NSI_NavController_index;
@property (nonatomic, readwrite) NSInteger NSI_last_Id_DDBB;
@property (nonatomic, readwrite) NSInteger NSI_num_new_order;
@property (nonatomic, readwrite) NSInteger NSI_numRecordBlock;

@property (nonatomic, readwrite) NSInteger NSI_blocksize_restaurants;
@property (nonatomic, readwrite) NSInteger NSI_blocksize_offers;
@property (nonatomic, readwrite) NSInteger NSI_blocksize_orders;

@property (nonatomic, retain) NSString *NSS_deviceToken;
@property (nonatomic, retain) NSString *NSS_msg_error;

@property (nonatomic, readwrite) BOOL B_valueFavoritos;
@property (nonatomic, readwrite) NSInteger NSI_value;

@property (nonatomic, retain) FacebookClass  *FC_facebook;
@property (nonatomic, retain) MensajeClass   *MC_mensaje;
@property (nonatomic, retain) TarjetaClass   *TC_creditcard;
@property (nonatomic, retain) ImageClass     *IC_image;
@property (nonatomic, retain) DireccionClass *DC_direccion;

@property (nonatomic, retain) AESCryptClass *AES_crypt;

@property (nonatomic, readwrite) BOOL B_usuario_registrado;
@property (nonatomic, readwrite) BOOL B_realizando_pedido;
@property (nonatomic, readwrite) BOOL B_pedido_confirmado;
@property (nonatomic, readwrite) BOOL B_come_from_historial;
@property (nonatomic, readwrite) BOOL B_come_from_mi_saco;
@property (nonatomic, readwrite) BOOL B_origen_mi_saco;
@property (nonatomic, readwrite) BOOL B_guardar_usuario;
@property (nonatomic, readwrite) BOOL B_pedido_en_cocina;
@property (nonatomic, readwrite) BOOL B_options;
@property (nonatomic, readwrite) BOOL B_datos_introducidos;
@property (nonatomic, readwrite) BOOL B_cargar_imagenes;
@property (nonatomic, readwrite) BOOL B_come_from_condiciones_legales;
@property (nonatomic, readwrite) BOOL B_data_historico_updated;
@property (nonatomic, readwrite) BOOL B_registro_facebook;
@property (nonatomic, readwrite) BOOL B_restaurante_con_fidelizacion;
@property (nonatomic, readwrite) BOOL B_login_from_reserva;
@property (nonatomic, readwrite) BOOL B_active_en_mesa;
@property (nonatomic, readwrite) BOOL B_come_from_instrucciones;
@property (nonatomic, readwrite) BOOL B_change_password;

@property (nonatomic, readwrite) BOOL B_UMNI_getRestaurants_active;
@property (nonatomic, readwrite) BOOL B_UMNI_getOrders_active;
@property (nonatomic, readwrite) BOOL B_UMNI_getOffers_active;

@property (nonatomic, retain) SearchRestaurantClass *SRC_search;
@property (nonatomic, retain) SearchOfferClass *SOC_search;

@property (nonatomic, retain) UserClass *UC_user;
@property (nonatomic, retain) FoodClass *FC_food;

@property (nonatomic, retain) OrderClass *OC_order;
@property (nonatomic, retain) OrderClass *OC_order_en_cocina;
@property (nonatomic, retain) OrderFoodClass *OFC_order_food;

@property (nonatomic, retain) NSMutableArray *NSMA_tabbar_viewcontroller;
@property (nonatomic, readwrite) NSInteger NSI_tabbar_index;

@property (nonatomic, retain) LoadingViewController *LVC_loading;

@property (nonatomic, retain) TabbarPrincipalViewController   *TPVC_principal;
@property (nonatomic, retain) TabbarDomicilioViewController   *TPVC_domicilio;
@property (nonatomic, retain) TabbarRestauranteViewController *TPVC_restaurante;
@property (nonatomic, retain) TabbarAntesLlegarViewController *TPVC_antesllegar;
@property (nonatomic, retain) TabbarRecogerViewController     *TPVC_recoger;

@property (nonatomic, retain) CoreLocationClass *CLC_location;
@property (nonatomic, retain) CoreDataClass *CDC_coreData;
@property (nonatomic, retain) JSONparseClass *JPC_json;

@property (nonatomic, retain) NSMutableArray *NSMA_restaurants;
@property (nonatomic, retain) NSMutableArray *NSMA_direcciones;
@property (nonatomic, retain) NSMutableArray *NSMA_tarjetas;
@property (nonatomic, retain) NSMutableArray *NSMA_orders;
@property (nonatomic, retain) NSMutableArray *NSMA_mi_saco;
@property (nonatomic, retain) NSMutableArray *NSMA_tipos_cocina;

@property (nonatomic, assign) BOOL B_FromHistory;




+ (SingletonGlobal *)sharedGlobal;


-(BOOL) chekInternetConnection;
-(void) showAlerMsgWith:(NSString *)NSS_title message:(NSString *)NSS_message;
-(void) showNoOfferAllowedMessage;
-(void) showNoOfferCategoryMessage;

-(NSString *) formatDistanceWithMeters:(CGFloat)CGF_distanceInMeters;
-(NSString *) formatTarjetaNumber:(TarjetaClass *)TC_tarjeta;

-(NSString *) urlEncodeValue:(NSString *)str;
-(NSDate *) getNSDateFromDateString:(NSString *)NSS_date;

-(TipoCocinaClass *)getRestautanttypeWithId:(NSString*)NSI_id;
-(TipoCocinaClass *)getRestautanttypeWithName:(NSString *)NSS_name;
-(FoodClass *)getFoodWithId:(NSInteger)NSI_id;

-(BOOL) exitsFood:(NSInteger)NSI_idfood category:(NSInteger)NSI_idfoodcategories;

-(int) iPosMenuOfFood:(OrderFoodClass *)OFC_food;
-(CGFloat) priceOfMenuOfFood:(OrderFoodClass *)OFC_food;
-(NSString *) nameOfMenuOfFood:(OrderFoodClass *)OFC_food;

-(NSString*) stringWithHexBytes:(NSData *)NSD_in;

-(void) recomiendo_en_facebook;

-(TarjetaClass *) getCreditCardFor:(NSString *)NSS_number;
-(NSInteger) newCreditCardId;

-(BOOL) checkEmailFormat:(NSString *)NSS_email;

-(NSString *) decrypEAS128:(NSString *)NSS_crypt;
-(NSString *) encrypEAS128:(NSString *)NSS_text;


@end