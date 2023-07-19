From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 5/9] vgacon: remove screen_info dependency
Date: Wed, 19 Jul 2023 15:49:22 +0200
Message-ID: <32595080-dd79-5cf0-46e7-b82d0df8f067@linaro.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-6-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b8lFeRfLQvQ3Mt560V7pURXN+oSgtj6Ib7beBeO95bA=; b=fTUzLNrVuXeTVp
	1g3bGtAXCcssxKMSaxu5minioT5nESxxGKCGJQK2v/XMgvcbdcAxz3GKLk6EMfNwSk8IIT43zgI1Y
	BXclaBq3dlLSz3wjPvJWGLNcjtgTz+keABWlHv6L5PNS8cWbcDyat3oKsyfszYJ9p1k6gRk7NZa72
	vKs5yI64DNadRfVL/zvhlxp8Mgz6PdDye6wT5+NP9gthSTAeCLuaINCYz4yhm/G8yWxDFo+pNdlDu
	OOXOgPzZCrpqBPFhbvYUC2IU9WkEc+67xW13WgLc/BvHEQditBwWnDlmPuJ82FxrwbZs4pp3KLYDd
	1UPZZm3z7jwxuAggRwAQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689774570; x=1692366570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeaSSoZd0P4aBDcnBZ8BgOhayrU2NW5OGYbO05NkL/4=;
        b=mSLGK2c7L5EE4FfadrFnGKrx8rHqMorl3CkK/H11fHsq3cy4XSsKtutECoQcxj7VUH
         6217O/9tcynPgDcZCiS5kwgKPRQ9yaxcBfet9pGpjP3OtetZCluXE3f4KQeLL37dXcdq
         Shyafc4xZzvzAf3/I3duYT0A6Lan59ePh67EPf8B6LGZv9LJEeK4tH3b6lkOaji6veEW
         jV3wN5L8eRb0FEZEQdFL5i8bBvckl20VHoXJydGdhlh18d4M6Z7KwE4oD2NfJGaix4SY
         m60NOgE8+OkCmcQdiCC141H+NDbenv1Kvjlt/AYNlG4in4PaDFI5cUWT/kWWjIB6GhTf
         8q+A==
Content-Language: en-US
In-Reply-To: <20230719123944.3438363-6-arnd@kernel.org>
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
To: Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Khalid Aziz <khalid@gonehiking.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Turner <mattst88@gmail.com>, Max

Hi Arnd,

On 19/7/23 14:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The vga console driver is fairly self-contained, and only used by
> architectures that explicitly initialize the screen_info settings.
> 
> Chance every instance that picks the vga console by setting conswitchp
> to call a function instead, and pass a reference to the screen_info
> there.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/alpha/kernel/setup.c      |  2 +-
>   arch/arm/kernel/setup.c        |  2 +-
>   arch/ia64/kernel/setup.c       |  2 +-
>   arch/mips/kernel/setup.c       |  2 +-
>   arch/x86/kernel/setup.c        |  2 +-
>   drivers/firmware/pcdp.c        |  2 +-
>   drivers/video/console/vgacon.c | 68 ++++++++++++++++++++--------------
>   include/linux/console.h        |  7 ++++
>   8 files changed, 53 insertions(+), 34 deletions(-)


> @@ -1074,13 +1077,13 @@ static int vgacon_resize(struct vc_data *c, unsigned int width,
>   		 * Ho ho!  Someone (svgatextmode, eh?) may have reprogrammed
>   		 * the video mode!  Set the new defaults then and go away.
>   		 */
> -		screen_info.orig_video_cols = width;
> -		screen_info.orig_video_lines = height;
> +		vga_si->orig_video_cols = width;
> +		vga_si->orig_video_lines = height;
>   		vga_default_font_height = c->vc_cell_height;
>   		return 0;
>   	}
> -	if (width % 2 || width > screen_info.orig_video_cols ||
> -	    height > (screen_info.orig_video_lines * vga_default_font_height)/
> +	if (width % 2 || width > vga_si->orig_video_cols ||
> +	    height > (vga_si->orig_video_lines * vga_default_font_height)/
>   	    c->vc_cell_height)
>   		return -EINVAL;
>   
> @@ -1110,8 +1113,8 @@ static void vgacon_save_screen(struct vc_data *c)
>   		 * console initialization routines.
>   		 */
>   		vga_bootup_console = 1;
> -		c->state.x = screen_info.orig_x;
> -		c->state.y = screen_info.orig_y;
> +		c->state.x = vga_si->orig_x;
> +		c->state.y = vga_si->orig_y;

Not really my area, so bare with me if this is obviously not
possible :) If using DUMMY_CONSOLE, can we trigger a save_screen
/ resize? If so, we'd reach here with vga_si=NULL.

>   	}
>   
>   	/* We can't copy in more than the size of the video buffer,
> @@ -1204,4 +1207,13 @@ const struct consw vga_con = {
>   };
>   EXPORT_SYMBOL(vga_con);
>   
> +void vgacon_register_screen(struct screen_info *si)
> +{
> +	if (!si || vga_si)
> +		return;
> +
> +	conswitchp = &vga_con;
> +	vga_si = si;
> +}
