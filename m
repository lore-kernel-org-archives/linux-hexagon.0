From: Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [03/12] sysfb: Do not include <linux/screen_info.h> from sysfb
 header
Date: Wed, 5 Jul 2023 09:41:51 +0800
Message-ID: <6fc51f26-6844-6fa0-23be-81aa5ac50fd6@loongson.cn>
References: <20230629121952.10559-4-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gvZ9NMZvWIpaKZ/PQkXh3trj5beMVOFJo5DYVQsTL+8=; b=U83LmORDdZxFWj
	q3d6aRsnO7iHxjS1y+RwXoTxx/uHTqqhKdcCtCtUhHn5fFL+RrV7zjw3+mYKp88uSpytNUI6aZyCj
	MG25dNgXGJpJUc1U1fthpc43RwXsgHvDL0ehQlFmw2HLUlPQ46DadgaHuUCuB2xiBse5ng8nUaJy8
	2MwO9rC+SJXmFum5r3CQB9zBEtPcUNENWojzob1Evr+lvf86UmUqjlPzA7Mj4ncdgohOo2sB+KEMN
	oxcLiEoWTxBD1SUSeSarNfJUkSXi6yfmESJ3qq18insx+pjLUFcRy14z9dMfT6A2CHmCnCOQ9/KKX
	J+750hdDLPOJHnskOQRA==;
Content-Language: en-US
In-Reply-To: <20230629121952.10559-4-tzimmermann@suse.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, Javier Martinez Canillas <javierm@redhat.com>, linux-csky@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> The header file <linux/sysfb.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> ---
>   include/linux/sysfb.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index c1ef5fc60a3cb..19cb803dd5ecd 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -9,7 +9,8 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/platform_data/simplefb.h>
> -#include <linux/screen_info.h>
> +
> +struct screen_info;
>   
>   enum {
>   	M_I17,		/* 17-Inch iMac */
