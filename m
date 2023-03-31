From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean()
 helper
Date: Fri, 31 Mar 2023 16:12:32 +0100
Message-ID: <cc3a78b6-b126-226f-b41a-061716aacd15@arm.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
 <cb9367fb-0897-244d-15b6-fdfafde2a1c0@arm.com>
 <df6340c8-6ac2-4459-a9e5-c411020962d6@app.fastmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Language: en-GB
In-Reply-To: <df6340c8-6ac2-4459-a9e5-c411020962d6@app.fastmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@ph>

On 31/03/2023 3:00 pm, Arnd Bergmann wrote:
> On Mon, Mar 27, 2023, at 14:48, Robin Murphy wrote:
>> On 2023-03-27 13:13, Arnd Bergmann wrote:
>>>
>>> [ HELP NEEDED: can anyone confirm that it is a correct assumption
>>>     on arm that a cache-coherent device writing to a page always results
>>>     in it being in a PG_dcache_clean state like on ia64, or can a device
>>>     write directly into the dcache?]
>>
>> In AMBA at least, if a snooping write hits in a cache then the data is
>> most likely going to get routed directly into that cache. If it has
>> write-back write-allocate attributes it could also land in any cache
>> along its normal path to RAM; it wouldn't have to go all the way.
>>
>> Hence all the fun we have where treating a coherent device as
>> non-coherent can still be almost as broken as the other way round :)
> 
> Ok, thanks for the information. I'm still not sure whether this can
> result in the situation where PG_dcache_clean is wrong though.
> 
> Specifically, the question is whether a DMA to a coherent buffer
> can end up in a dirty L1 dcache of one core and require to write
> back the dcache before invalidating the icache for that page.
> 
> On ia64, this is not the case, the optimization here is to
> only flush the icache after a coherent DMA into an executable
> user page, while Arm only does this for noncoherent DMA but not
> coherent DMA.
> 
>  From your explanation it sounds like this might happen,
> even though that would mean that "coherent" DMA is slightly
> less coherent than it is elsewhere.
> 
> To be on the safe side, I'd have to pass a flag into
> arch_dma_mark_clean() about coherency, to let the arm
> implementation still require the extra dcache flush
> for coherent DMA, while ia64 can ignore that flag.

Coherent DMA on Arm is assumed to be inner-shareable, so a coherent DMA 
write should be pretty much equivalent to a coherent write by another 
CPU (or indeed the local CPU itself) - nothing says that it *couldn't* 
dirty a line in a data cache above the level of unification, so in 
general the assumption must be that, yes, if coherent DMA is writing 
data intended to be executable, then it's going to want a Dcache clean 
to PoU and an Icache invalidate to PoU before trying to execute it. By 
comparison, a non-coherent DMA transfer will inherently have to 
invalidate the Dcache all the way to PoC in its dma_unmap, thus cannot 
leave dirty data above the PoU, so only the Icache maintenance is 
required in the executable case.

(FWIW I believe the Armv8 IDC/DIC features can safely be considered 
irrelevant to 32-bit kernels)

I don't know a great deal about IA-64, but it appears to be using its 
PG_arch_1 flag in a subtly different manner to Arm, namely to optimise 
out the *Icache* maintenance. So if anything, it seems IA-64 is the 
weirdo here (who'd have guessed?) where DMA manages to be *more* 
coherent than the CPUs themselves :)

This is all now making me think we need some careful consideration of 
whether the benefits of consolidating code outweigh the confusion of 
conflating multiple different meanings of "clean" together...

Thanks,
Robin.
