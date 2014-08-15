From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set
	endian explicitly
Date: Fri, 15 Aug 2014 05:52:09 +0400
Message-ID: <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
References: <53ECE9DD.80004@gmail.com>
	<CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=DAZSQCzv6arI+V++2yNFiX+GMu/Q0DjeQC2RE+Shoqk=;
	b=b7GrHfpZ9hFD/byJsJdrpxEhtpcKpL77INrYIT4hN4sHmJgwV7eOYrL2zv9UZEkyeK
	y/sk6tuMrFV3M6N522tMKJslqrBNzEUY9Oi7fb2AZbV4r9x43FN8jFneMukgdfjsu62N
	iB/RbpGPFsaPZ798Temjw0AYG65UoJv2WCiwmcwuORqso1jQbFq5/aE4/S6QzoQgI11G
	7YOaF3VobEQmr2zxOaB00FxJ3O3p2NLHrWnu0aRLqqjwJgHEkoMzI1wsAgJmV5CvnHEN
	27P3P156pGH60T+mP0Bl8d0/MeLoVq0u8/vCLyiGB439jMPBu1E90E2SLzBO517H2pjZ
	ETdA==
In-Reply-To: <CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Linux/MIPS Mailing List <linux-mips@linux-mips.org>, linux-s390@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Catalin Marinas <catalin.marinas@arm.com>, linux@lists.openrisc.net, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jean Delvare <jdelvare@suse.de>, egtvedt@samfundet.no, Liqin Chen <liqin.linux@gmail.com>, jesper.nilsson@axis.com, linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org, "David S. Miller" <davem@davemloft.net>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Michael Ellerman <mpe@ellerman.id.au>, takata@linux-m32r.org, x86@kernel.org, jejb@paris

On Fri, Aug 15, 2014 at 5:47 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Chen,
>
> On Thu, Aug 14, 2014 at 8:54 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
>> Normal architectures:
>>
>>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>>
>>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>>                   score, unicore32, x86
>>
>>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>>
>> Special architectures:
>>
>>  - Deside by compiler: microblaze, tile, xtensa.
>>
>>  - Deside by building host: um
>>
>>  - Next, need improve Kbuild to probe endian to deside whether need mark
>>    __BUILDING_TIME_BIG_ENDIAN__ before real config.
>
> [...]
>
>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>> index 3a617af..a3e8f7e 100644
>> --- a/arch/xtensa/Kconfig
>> +++ b/arch/xtensa/Kconfig
>> @@ -22,6 +22,8 @@ config XTENSA
>>         select HAVE_IRQ_TIME_ACCOUNTING
>>         select HAVE_PERF_EVENTS
>>         select COMMON_CLK
>> +       select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
>> +       select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>         help
>>           Xtensa processors are 32-bit RISC machines designed by Tensilica
>>           primarily for embedded systems.  These processors are both
>
> I've tested this part and it doesn't select neither CPU_BIG_ENDIAN,
> nor CPU_LITTLE_ENDIAN. And looking into the Kconfig/Kbuild I cound't

Correction: it always selects CPU_LITTLE_ENDIAN, regardless of the
compiler endianness.

> find anything related to __BUILDING_TIME_BIG_ENDIAN__. Am I missing
> something?

-- 
Thanks.
-- Max
