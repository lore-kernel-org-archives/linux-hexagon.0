From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/35] defconfig: Cleanup from old entries
Date: Mon, 12 Jun 2017 11:54:51 +0200
Message-ID: <CAK8P3a3YN+5aJdqxwnpZaVpuucsmQUE3BuEpAf+q7uPXa1dgZw@mail.gmail.com>
References: <20170608160836.12196-1-krzk@kernel.org>
 <CAK8P3a3bUeC3H2oNfdBedVY4UTCe8OgKbWmv46d5xfu8tC7tAg@mail.gmail.com>
 <20170610164351.7sxzvj4ojj3fbc7h@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aDCyd+eSYPIHEeGPWiRauiAYT/65IBlcoqSVTcs0X3c=; b=j9NPSCJB6r6UUM
	HJ8YrX19R2aiNSMTntdl5cUVxjQmOo6PR+zGDNdYF9xAuRROXfBpFB6nY4mrw965IoCAn7+NPWaJW
	4r10KXRpm+KkvmB7sEcBURVXTxy+sV9pduvLvjB0uBcSVhFYlxsy0dqVjSAoumSNaGA52RwL1o9Hp
	BJg2RnGb5KkHudLUsQtPau+LhnqZAU2Gw+Tk93urg5zMjBSrywivXxqUlITDcrA831Q94jvxZhDsg
	DCvJI/DJWxZTKwESQ2vBJv3+4aFTTu7Siq1y9Pfmdoe1sqg3lN1J8mVbqVJ6xUxB5zY2ooFc2RaD2
	7ddcIVbbdiHb5wi4LDKw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:sender:in-reply-to:references:from:date:message-id
 :subject:to:cc;
 bh=5UD3gm0jnS4PGM3GtYlJtJw697j54IOqC5FYpDahZCM=;
 b=CI1xk7y/avGUkC4KtVI5MFor5K46ZCeEQCiY5IoPxbVNDYuyCjMahUmchP8+pFBVQg
 BPV75isr8030AyboHjNoz61/WiIw8i1Mfst6is4XbAz6r+my0K4VExPN8GliMm7x8G8s
 Wtt39B4gVkweXsRgop3a2PItVTt+E0Euf+pWejf7AlYheD3q0r+GpJGx1DECcxgPY+n5
 VpVTyc+zuf50s/bgEg6Cfm020aHfwx049vsStyeByCTq5OS9CyH5XV3d8VquWuD4eiYd
 zCsJL0yIVYa65hL/HTvNWIquj1y7C0nUziemlJjJITkaJ+7wjsVkaftUXMtOQ7GU7dB5
 gd9g==
In-Reply-To: <20170610164351.7sxzvj4ojj3fbc7h@kozik-lap>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Tony Lindgren <tony@atomide.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Liviu Dudau <liviu.dudau@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-sh@vger.kernel.org

On Sat, Jun 10, 2017 at 6:43 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Jun 09, 2017 at 09:59:48PM +0200, Arnd Bergmann wrote:
>> On Thu, Jun 8, 2017 at 6:08 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > Hi,
>> >
>> > While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
>> > similar obsolete entries in other files.
>> >
>> > Except the ARM, no dependencies.
>> > For ARM, the rest of patches depend on the first change (otherwise
>> > it might not apply cleanly).
>>
>> Great work!
>>
>> I looked at all the ARM patches, and everything looks good to me (the
>> changlog linewrapping may be suboptimal for readability in some cases,
>> if I had to say anything negative ;-) ).
>>
>> Please add my Acked-by to the ARM patches and send a pull request.
>
> Thanks, I'll send you ARM part in pull request.

Ok

> As for the rest, I think respective arch/platform maintainers should
> take it.

I suspect most will apply the patches, but some architectures maintainers
are not very active. If you are motivated, you could resend the ones
that missed out to Andrew Morton, or you just leave the architectures
to bitrot more. ;-)

     Arnd
