From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/3] futex: remove duplicated code
Date: Wed, 8 Mar 2017 22:16:49 -0600
Message-ID: <23e5808b-2a20-518d-b49a-4d95dd23cfde@landley.net>
References: <20170303122712.13353-1-jslaby@suse.cz>
 <20170304130550.GT21222@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OhUHJSE5xU6QMGVnJZxnedbXx+uYtbUUiw2eHUGexbc=;
        b=x9/eJRzZHDDBHbBVNWBBuWp935tC5GuX3kZhgkgijhR3tsRQ7L5dU/NpbpAI5N04pM
         460Vjh3374vT3oKaXYqfPQfOv6TAldpV4sSM59MZOB59MsA4JcxcmrsJJieDM7Fmt16e
         U0vwgft7qcoWC4PHgXDPogNvAFGk/RsyUf4OUC6E0qMSJBzeMiLaMoFIb9GMGTILExoA
         znpddWFZ16MaDxZUGU1MtE0pWckaRcAMGeD/4ncjPMWJ182IMuWUfNMv8iQQRgf3JyFJ
         bvynm4ZslcpaenqeG5vkypNLlB1MmiRDM1pI3+Ls+ncPb7bubCed+bpolfsmg1SJD08k
         IZ0A==
In-Reply-To: <20170304130550.GT21222@n2100.armlinux.org.uk>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.cz>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>

On 03/04/2017 07:05 AM, Russell King - ARM Linux wrote:
> On Fri, Mar 03, 2017 at 01:27:10PM +0100, Jiri Slaby wrote:
>> diff --git a/kernel/futex.c b/kernel/futex.c
>> index b687cb22301c..c5ff9850952f 100644
>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -1457,6 +1457,42 @@ futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
>>  	return ret;
>>  }
>>  
>> +static int futex_atomic_op_inuser(int encoded_op, u32 __user *uaddr)
>> +{
>> +	int op = (encoded_op >> 28) & 7;
>> +	int cmp = (encoded_op >> 24) & 15;
>> +	int oparg = (encoded_op << 8) >> 20;
>> +	int cmparg = (encoded_op << 20) >> 20;
> 
> Hmm.  oparg and cmparg look like they're doing these shifts to get sign
> extension of the 12-bit values by assuming that "int" is 32-bit -
> probably worth a comment, or for safety, they should be "s32" so it's
> not dependent on the bit-width of "int".

I thought Linux depended on the LP64 standard for all architectures?

Standard: http://www.unix.org/whitepapers/64bit.html
Rationale: http://www.unix.org/version2/whatsnew/lp64_wp.html

So int has a defined bit width (32) on linux?

Rob
