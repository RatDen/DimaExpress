PGDMP                 	    	    {            DimaExpress    15.1    15.1 .    +           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ,           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            -           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            .           1262    32876    DimaExpress    DATABASE     �   CREATE DATABASE "DimaExpress" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "DimaExpress";
                postgres    false            �            1259    32941    buyer    TABLE       CREATE TABLE public.buyer (
    id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(100) NOT NULL,
    phone character(11) NOT NULL,
    address character varying(100) NOT NULL
);
    DROP TABLE public.buyer;
       public         heap    postgres    false            �            1259    32940    buyer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.buyer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.buyer_id_seq;
       public          postgres    false    215            /           0    0    buyer_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.buyer_id_seq OWNED BY public.buyer.id;
          public          postgres    false    214            �            1259    32948 	   cart_list    TABLE     �   CREATE TABLE public.cart_list (
    product_id integer NOT NULL,
    buyer_id integer NOT NULL,
    quantity numeric(7,0) NOT NULL
);
    DROP TABLE public.cart_list;
       public         heap    postgres    false            �            1259    32957    orders    TABLE     �   CREATE TABLE public.orders (
    buyer_id integer NOT NULL,
    id integer NOT NULL,
    date date NOT NULL,
    address character varying(300) NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    32956    order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_id_seq;
       public          postgres    false    218            0           0    0    order_id_seq    SEQUENCE OWNED BY     >   ALTER SEQUENCE public.order_id_seq OWNED BY public.orders.id;
          public          postgres    false    217            �            1259    32965 
   order_list    TABLE     �   CREATE TABLE public.order_list (
    product_id integer NOT NULL,
    order_buyer_id integer NOT NULL,
    order_id integer NOT NULL,
    quantity numeric(7,0) NOT NULL
);
    DROP TABLE public.order_list;
       public         heap    postgres    false            �            1259    32974    product    TABLE     �   CREATE TABLE public.product (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(512) NOT NULL,
    price integer NOT NULL,
    image character varying(100) NOT NULL
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    32973    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    221            1           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    220            w           2604    32944    buyer id    DEFAULT     d   ALTER TABLE ONLY public.buyer ALTER COLUMN id SET DEFAULT nextval('public.buyer_id_seq'::regclass);
 7   ALTER TABLE public.buyer ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            x           2604    32960 	   orders id    DEFAULT     e   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            y           2604    32977 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            "          0    32941    buyer 
   TABLE DATA           Q   COPY public.buyer (id, first_name, last_name, email, phone, address) FROM stdin;
    public          postgres    false    215   Y3       #          0    32948 	   cart_list 
   TABLE DATA           C   COPY public.cart_list (product_id, buyer_id, quantity) FROM stdin;
    public          postgres    false    216   �3       &          0    32965 
   order_list 
   TABLE DATA           T   COPY public.order_list (product_id, order_buyer_id, order_id, quantity) FROM stdin;
    public          postgres    false    219   �3       %          0    32957    orders 
   TABLE DATA           =   COPY public.orders (buyer_id, id, date, address) FROM stdin;
    public          postgres    false    218   4       (          0    32974    product 
   TABLE DATA           F   COPY public.product (id, name, description, price, image) FROM stdin;
    public          postgres    false    221   V4       2           0    0    buyer_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.buyer_id_seq', 2, true);
          public          postgres    false    214            3           0    0    order_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.order_id_seq', 14, true);
          public          postgres    false    217            4           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 11, true);
          public          postgres    false    220            |           2606    32946    buyer pk_buyer 
   CONSTRAINT     L   ALTER TABLE ONLY public.buyer
    ADD CONSTRAINT pk_buyer PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.buyer DROP CONSTRAINT pk_buyer;
       public            postgres    false    215            �           2606    32952    cart_list pk_cart_list 
   CONSTRAINT     f   ALTER TABLE ONLY public.cart_list
    ADD CONSTRAINT pk_cart_list PRIMARY KEY (product_id, buyer_id);
 @   ALTER TABLE ONLY public.cart_list DROP CONSTRAINT pk_cart_list;
       public            postgres    false    216    216            �           2606    32962    orders pk_order 
   CONSTRAINT     W   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT pk_order PRIMARY KEY (buyer_id, id);
 9   ALTER TABLE ONLY public.orders DROP CONSTRAINT pk_order;
       public            postgres    false    218    218            �           2606    32969    order_list pk_order_list 
   CONSTRAINT     x   ALTER TABLE ONLY public.order_list
    ADD CONSTRAINT pk_order_list PRIMARY KEY (product_id, order_buyer_id, order_id);
 B   ALTER TABLE ONLY public.order_list DROP CONSTRAINT pk_order_list;
       public            postgres    false    219    219    219            �           2606    32981    product pk_product 
   CONSTRAINT     P   ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.product DROP CONSTRAINT pk_product;
       public            postgres    false    221            z           1259    32947    buyer_pk    INDEX     ?   CREATE UNIQUE INDEX buyer_pk ON public.buyer USING btree (id);
    DROP INDEX public.buyer_pk;
       public            postgres    false    215            }           1259    32955    cart_list2_fk    INDEX     G   CREATE INDEX cart_list2_fk ON public.cart_list USING btree (buyer_id);
 !   DROP INDEX public.cart_list2_fk;
       public            postgres    false    216            ~           1259    32954    cart_list_fk    INDEX     H   CREATE INDEX cart_list_fk ON public.cart_list USING btree (product_id);
     DROP INDEX public.cart_list_fk;
       public            postgres    false    216                       1259    32953    cart_list_pk    INDEX     Y   CREATE UNIQUE INDEX cart_list_pk ON public.cart_list USING btree (product_id, buyer_id);
     DROP INDEX public.cart_list_pk;
       public            postgres    false    216    216            �           1259    32972    order_list2_fk    INDEX     Y   CREATE INDEX order_list2_fk ON public.order_list USING btree (order_buyer_id, order_id);
 "   DROP INDEX public.order_list2_fk;
       public            postgres    false    219    219            �           1259    32971    order_list_fk    INDEX     J   CREATE INDEX order_list_fk ON public.order_list USING btree (product_id);
 !   DROP INDEX public.order_list_fk;
       public            postgres    false    219            �           1259    32970    order_list_pk    INDEX     k   CREATE UNIQUE INDEX order_list_pk ON public.order_list USING btree (product_id, order_buyer_id, order_id);
 !   DROP INDEX public.order_list_pk;
       public            postgres    false    219    219    219            �           1259    32963    order_pk    INDEX     J   CREATE UNIQUE INDEX order_pk ON public.orders USING btree (buyer_id, id);
    DROP INDEX public.order_pk;
       public            postgres    false    218    218            �           1259    32964 
   ordered_fk    INDEX     A   CREATE INDEX ordered_fk ON public.orders USING btree (buyer_id);
    DROP INDEX public.ordered_fk;
       public            postgres    false    218            �           1259    32982 
   product_pk    INDEX     C   CREATE UNIQUE INDEX product_pk ON public.product USING btree (id);
    DROP INDEX public.product_pk;
       public            postgres    false    221            �           2606    32988 %   cart_list fk_cart_lis_cart_list_buyer    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_list
    ADD CONSTRAINT fk_cart_lis_cart_list_buyer FOREIGN KEY (buyer_id) REFERENCES public.buyer(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 O   ALTER TABLE ONLY public.cart_list DROP CONSTRAINT fk_cart_lis_cart_list_buyer;
       public          postgres    false    3196    215    216            �           2606    32983 '   cart_list fk_cart_lis_cart_list_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_list
    ADD CONSTRAINT fk_cart_lis_cart_list_product FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.cart_list DROP CONSTRAINT fk_cart_lis_cart_list_product;
       public          postgres    false    221    3212    216            �           2606    33003 &   order_list fk_order_li_order_lis_order    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_list
    ADD CONSTRAINT fk_order_li_order_lis_order FOREIGN KEY (order_buyer_id, order_id) REFERENCES public.orders(buyer_id, id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 P   ALTER TABLE ONLY public.order_list DROP CONSTRAINT fk_order_li_order_lis_order;
       public          postgres    false    219    218    219    218    3205            �           2606    32998 (   order_list fk_order_li_order_lis_product    FK CONSTRAINT     �   ALTER TABLE ONLY public.order_list
    ADD CONSTRAINT fk_order_li_order_lis_product FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 R   ALTER TABLE ONLY public.order_list DROP CONSTRAINT fk_order_li_order_lis_product;
       public          postgres    false    219    3212    221            �           2606    32993    orders fk_order_ordered_buyer    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_order_ordered_buyer FOREIGN KEY (buyer_id) REFERENCES public.buyer(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk_order_ordered_buyer;
       public          postgres    false    215    218    3196            "   >   x�3�t��M�)�O���/�LK�Nu�M���+*崰420426153���,H-)������ �R�      #      x������ � �      &   B   x�5���0C�s�0'��]���\�'[�L�,�2w�й����S�m��Ur�_壄7�x�*g9      %   0   x�3��4202�50�50���,H-)��2�44�!n�7����qqq }]�      (   �  x���OkA ���S<<�(�����ln��(���r�6K	M2!��xJZ��V�
E�*�bQk�O0�|�MM�Ͷl��Bȼ};�xo�PK�Ǻk�f˼�=}O���Wa�4]�"_gR8���0��ҟ��i�>Ƀ�p�[0�B�S"�8LKg� ov�����fs�Ƀ>0��Ʒ��t�.�s����>s�-�U�ףeL�Q�p���9
ӆ��u���`p��#a��z����#��[����m`l;������ż
w���`��:)�������VUP�E���Z_)��-U�X^_+��ĳ`��c���A�g�z ��S 9I��<5���b��jJYԳ7��ʄ�}�*'�W}��זU��Yi�+�B"�B�"Z;I�
�Z=	b2.Ҋs�����,wF�{�[?``��7d��T�b���q:I�ř��,4��*0�l�Ϛ>���R��.C�s#�r����9�c0V\���K����4�9���a5���d��΀2Sq^��G]��_�8)6<�[��R�O#��p��p
K�f�2�v��������_90���q?��O�{��3>y�ϝ+��2�b��7�m(`�M��7r��3g�_l�?��ፏ���IiQ�҄��4���fuS�S�ypyO_zB���~"e��0�"C�M+�Y��B�i�F�:Rv�q��I񟜎<#�t!�'r��/H��g     