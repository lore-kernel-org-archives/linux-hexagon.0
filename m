From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
Date: Fri, 15 Aug 2014 17:01:20 +0800
Message-ID: <53EDCC60.5040608@gmail.com>
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org> <53ED34CE.3040001@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VOeqw/n7UCD7wMmRLxfit5rey0ZmaJSVDygLXIGaB9g=;
        b=k3IYshbANurNxjIxvmqWAvWiikaWtHUqR+X+lmAlJjP/5jTWFLA6JGaODj+yzfwRzH
         BQFxBwglwpSJsVpmIEh5kO0DzTLWDCvZ7V3YMlMBLAHeO+stYkx1efLOLodmM7/W6ImM
         hurylFKXCDDO60sx9S49EFiYYEkbYPVCcalacUTq7NrnfAG2GyaLSP95H+Gw6D6ZGpfU
         jNOFq6CLFoQz51CKrGF10RJLaISITtyXAAOglQlaKuxhA0JGZGpEkEcGTyg9KUR0AnzH
         tlmnQlzXLwoq5U5N3t4cCuIbFZOdLRPbE8GjK8rUb35i9UobGEMan/XD1F2MeMCc54NO
         5dQQ==
In-Reply-To: <53ED34CE.3040001@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: <linux-hexagon.vger.kernel.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
Content-Type: text/plain; charset="us-ascii"
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>, yasutake.koichi@jp.panasonic.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, mpe@ellerman.id.au, Mart



On 8/15/14 6:14, Chen Gang wrote:
> On 08/15/2014 02:04 AM, Ralf Baechle wrote:
>>
> 
> OK, thanks, I assumes when support both endian, the default choice is
> CPU_BIG_ENDIAN, although no default value for choice (originally, I did
> worry about it).
> 
>> So I think you can just drop the MIPS segment from your patch.
>>
> 
> If what I assumes is correct, what you said sounds reasonable to me.
> 
> 

So for me, it is harmless to add CPU_*_ENDIAN explicitly, and can let
other members don't need think of.

By the way, for sh, it is almost the same case, except it contents the
default value, for me, it is clear enough, so I skip sh architecture in
this patch.


Thanks
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed

