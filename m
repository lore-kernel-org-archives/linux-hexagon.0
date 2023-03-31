From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
Date: Fri, 31 Mar 2023 18:09:16 +0100
Message-ID: <ZCcTvN5DAbjOVWUX@arm.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-19-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-19-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Mon, Mar 27, 2023 at 02:13:14PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The cache management operations for noncoherent DMA on ARMv6 work
> in two different ways:
> 
>  * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>    DMA buffers lead to data corruption when the prefetched data is written
>    back on top of data from the device.
> 
>  * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>    is not seen by the other core(s), leading to inconsistent contents
>    accross the system.
> 
> As a consequence, neither configuration is actually safe to use in a
> general-purpose kernel that is used on both MPCore systems and ARM1176
> with prefetching enabled.

As the author of this terrible hack (created under duress ;))

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

IIRC, RWFO is working in combination with the cache operations. Because
the cache maintenance broadcast did not happen, we forced the cache
lines to migrate to a CPU via a write (for ownership) and doing the
cache maintenance on that CPU (that was the FROM_DEVICE case). For the
TO_DEVICE case, reading on a CPU would cause dirty lines on another CPU
to be evicted (or migrated as dirty to the current CPU IIRC) then the
cache maintenance to clean them to PoC on the local CPU.

But there's always a small window between read/write for ownership and
the actual cache maintenance which can cause a cache line to migrate to
other CPUs if they do speculative prefetches. At the time ARM11MPCore
was deemed safe-ish but I haven't followed what later implementations
actually did (luckily we fixed the architecture in ARMv7).

-- 
Catalin
