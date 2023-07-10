From: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
Date: Sun, 9 Jul 2023 22:38:03 -0500
Message-ID: <fd95e3cb-d7b7-ec8b-c48b-d86634f07dfd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-4-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688960287;
        bh=v0OsTtvNKU6Dld3+w3JG1lJowk+7fQMnwswrEl/ZXho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I3vszjayKwTZgx7pu48sWg1k5KBKxkXctrW6bu353IwqtA9FDkUA7UB58Thl0EhHA
         B70Ik7KJ+gLjEd/EJMekP58Fj22ciYqtrwFfDgaE8piXiARykGJpw4fmJMr0abMiYv
         kznZLRTeIpAciA+le/inMAv0/2rIwFn7wPgoi0g6V+OEpDki3zv82reX0K4OX0Vk6U
         Pk3PpnvQIPIwP0lZqaH5XhB2u9jeRgPYAmJw6E9/kj6Hic8bm2+vgsnEqqkEqgA9Ri
         Z5P+PafgNNhL27TXboyzGxGeY4OuUhIK5umaEMLtbzeoYff/FKxbLMUD0g8AMLhDai
         VEhKaDKNhWjAg==
Content-Language: en-US
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org



On 7/7/23 04:52, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA
> console driver in an allmodconfig build.
> 
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/csky/kernel/setup.c          | 12 ------------
>   arch/hexagon/kernel/Makefile      |  2 --
>   arch/hexagon/kernel/screen_info.c |  3 ---
>   arch/nios2/kernel/setup.c         |  5 -----

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

