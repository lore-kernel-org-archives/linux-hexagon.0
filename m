From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
Date: Fri, 07 Jul 2023 15:42:46 +0200
Message-ID: <87edljyh0p.fsf@minerva.mail-host-address-is-not-set>
References: <20230707095415.1449376-1-arnd@kernel.org>
 <20230707095415.1449376-4-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+owWNOWvEK7SZ1O/p9+BsoqrhRbp6l42ZVJTUZNbK4=;
        b=hFsylKSxiQMJdoXtIazy4s9hWuqnlHLhVIMmLFnys7+MZ9Uuz54IihO1kQYG+sFZMvYPAV
        04g1eFWd7oSzkGbbORfz+ecROIUo8DeNwPWvzwzv3AnBqzurn347m30DYM20YdeSDFORCq
        6rTsAb6VHOXadwbxykmEMW/9yOwh/KQ=
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

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

Nice cleanup!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

