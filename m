From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Date: Sun, 12 Feb 2023 09:38:36 -0800
Message-ID: <64f2ba37-d869-0160-1a89-d7f15d243d05@roeck-us.net>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net> <Y+kTHsaq8FAG72CX@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gEc3d6k45zjDeEZHbol4IIwzjmxqM4mBWgDI31Sfc5o=;
        b=R330sse/EVLRGFL0igafPWieDgvfGLbUv1mxwjjJZAHpBvZcU2/Gg7Ye7o55WJDp/T
         d/MkHSIY+rV5WmpmEtSQ3EcpkVyHgH/g8WGwdicgdAr8s7fVYzB3M6AQYSXN1fWO7dsD
         adnG3ljI9LKreMS0IYacGj+zm2/uKWOjveyAMeTbeBXzAlA0+lDjE38oWr0kFL4x/3pl
         NtGAiadx3cotdBgXvBg6mFyqYNavUvZnDTVR9OSu3hxj7Glcs0NmbhgPuh+/V46P8f0N
         UAStFFymZhcq+751kC0Xe8LgThvdTeD+HxCq3F5UGXwSHXYBMgqQ0gCOk/Vyqx7W2YhY
         u2kw==
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Language: en-US
In-Reply-To: <Y+kTHsaq8FAG72CX@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel>

On 2/12/23 08:26, Mike Rapoport wrote:
> Hi Guenter,
> 
> On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
>> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> Every architecture that supports FLATMEM memory model defines its own
>>> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>>>
>>> Use mips/powerpc version implemented as static inline as a generic
>>> implementation of pfn_valid() and drop its per-architecture definitions.
>>>
>>
>> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
>> Reverting this patch fixes the problem.
>   
> Can you please test with only partial revert for arch/sh?
> 

Sure, that works as well.

Guenter

