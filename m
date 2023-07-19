From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v2 5/9] vgacon: remove screen_info dependency
Date: Wed, 19 Jul 2023 16:38:57 +0200
Message-ID: <3b047cd4-a61f-44b6-830b-b4e35bfccd72@app.fastmail.com>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-6-arnd@kernel.org>
 <32595080-dd79-5cf0-46e7-b82d0df8f067@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1689777595; x=1689784795; bh=nZU6p3n7fickF5wKWXmSN8Sc6/MSvsFTYGP
        0irgDDx8=; b=F6uhOe0xlOcUS4dDy1oq5df2GK1xAMcbSu8LZgoyXmvhlUzRu78
        bGWxTgJiJi6zrRqVfawYfkrNgFxRyoDY1fhSxgqhl2HFLNsxG4oCXLOUvtc1H1J9
        yKpHN5YOXPSGucUUa4WBBwirLFW7BcNoa9nEJIN8VY/wxM9DZRnEh0QMcm0tWtCR
        dKTHuIxJjhaZFzLsV9DTjnLCbGrttI4s9sB6wKBYnGTTcqvQf0+2gn/VHNspuTtL
        UCPm3ZVAMHyA6sMFGbrinOOlTU5JT8hRDtp3UUk+cM86plnrvFOW8ztaQcBfW6T8
        F6uE/5iwV3Pzt0P1Egm7uCnyHKH+4DwB/7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689777595; x=1689784795; bh=nZU6p3n7fickF5wKWXmSN8Sc6/MSvsFTYGP
        0irgDDx8=; b=RT3ufktFiEmOaEJtwn2kNPwX1CxJHO84CaryEahSFHfcxzKAOKP
        GbsmwKdkij2/wPBd7ZceYMaF8fRakoZMD4mqWlf0Zxmc3G8CDJFEJnfyubpj4GpK
        BTGeK/U7hKm6Xv3VxJI6XGVSS5z+dkFKgATEYbUSs/PzvBavnLdZpIWHdDX7DPwN
        15x30i+ixySDP0gi6hrqw9TjDxXFUe4m0DoLzGSNryLWDKksDFvYLsm8ExaZoHgl
        VF+nPTLS/vCYm/jinaZDPIrkGemb4sE71T5g0dm8v0j1hZVFJOBDNUTynb37Cocc
        llP48wfwjZ64vJQYBWEmvFIXuwbXcmFTjiw==
In-Reply-To: <32595080-dd79-5cf0-46e7-b82d0df8f067@linaro.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, linux-efi@vger.kernel.org, guoren <guoren@kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, "K. Y. Srinivasan" <kys@microsoft.com>, Dave Airlie <airlied@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, Wei Liu <wei.liu@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Dexuan Cui

On Wed, Jul 19, 2023, at 15:49, Philippe Mathieu-Daud=C3=A9 wrote:
> On 19/7/23 14:39, Arnd Bergmann wrote:

>> @@ -1074,13 +1077,13 @@ static int vgacon_resize(struct vc_data *c, u=
nsigned int width,
>>   		 * Ho ho!  Someone (svgatextmode, eh?) may have reprogrammed
>>   		 * the video mode!  Set the new defaults then and go away.
>>   		 */
>> -		screen_info.orig_video_cols =3D width;
>> -		screen_info.orig_video_lines =3D height;
>> +		vga_si->orig_video_cols =3D width;
>> +		vga_si->orig_video_lines =3D height;
>>   		vga_default_font_height =3D c->vc_cell_height;
>>   		return 0;
>>   	}
>> -	if (width % 2 || width > screen_info.orig_video_cols ||
>> -	    height > (screen_info.orig_video_lines * vga_default_font_heigh=
t)/
>> +	if (width % 2 || width > vga_si->orig_video_cols ||
>> +	    height > (vga_si->orig_video_lines * vga_default_font_height)/
>>   	    c->vc_cell_height)
>>   		return -EINVAL;
>>  =20
>> @@ -1110,8 +1113,8 @@ static void vgacon_save_screen(struct vc_data *=
c)
>>   		 * console initialization routines.
>>   		 */
>>   		vga_bootup_console =3D 1;
>> -		c->state.x =3D screen_info.orig_x;
>> -		c->state.y =3D screen_info.orig_y;
>> +		c->state.x =3D vga_si->orig_x;
>> +		c->state.y =3D vga_si->orig_y;
>
> Not really my area, so bare with me if this is obviously not
> possible :) If using DUMMY_CONSOLE, can we trigger a save_screen
> / resize? If so, we'd reach here with vga_si=3DNULL.
>

I think it cannot happen because the only way that anything calls
into vgacon.c is through the "conswitchp =3D &vga_con;" that now happens
at the same time as the "vga_si =3D &screen_info;". It's definitely
possible that I'm missing something as well here.

     Arnd
