From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 16:45:39 +1000
Message-ID: <874jnutizw.fsf@mail.lhotse>
References: <20230529111337.352990-1-maninder1.s@samsung.com>
 <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-2-maninder1.s@samsung.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685429145;
        bh=o7BSq9ytklugFOyDmLNWraah9D1SBaiKnYWrg8YWVzY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CClFspLelMasiQojGDSV8rakiv9SxUusKUuLe2+tTNTreFEwgNqa20yYFu/PgZ+R7
         r0cl9Vho5EdCDiXCqVIqaNXoTk21GJgPMBObVdcOdZmiaA/Sdrs+TRyxB014BcbM/b
         7wufiYNWGRITdYJ2jUQCpLtFH2Fb5NhZiAAY2+S1TP4e7CkJk7QuIrFHEMnx5SGD7J
         8tz7dc8QFP9a5BfAud4zEtHDKJmyAkax0KTTk5r++Vc3NSpFmfD/xyw78ypMuZvogC
         9r6pVCyEA0A/MRuMhDZQYGYvPJcvsynuikJt8ah4+ZlUQ9QIhteVoLhbPhxzeM2sxb
         HQ91XEKVPZ/Yg==
In-Reply-To: <20230529111337.352990-2-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maninder Singh <maninder1.s@samsung.com>, bcain@quicinc.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org, pmladek@suse.com, wedsonaf@google.com
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Maninder Singh <maninder1.s@samsung.com>, Onkarnath <onkarnath.1@samsung.com>

Maninder Singh <maninder1.s@samsung.com> writes:
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
>
> Thus array size should be KSYM_NAME_LEN.
>
> for powerpc it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
>
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

AFAICS that's the wrong sha.

That commit appears in linux-next, but the commit that actually went
into mainline is:

  b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")

So I'll update the change log to refer to that.

cheers

> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/powerpc/xmon/xmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 728d3c257e4a..70c4c59a1a8f 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -88,7 +88,7 @@ static unsigned long ndump = 64;
>  static unsigned long nidump = 16;
>  static unsigned long ncsum = 4096;
>  static int termch;
> -static char tmpstr[128];
> +static char tmpstr[KSYM_NAME_LEN];
>  static int tracing_enabled;
>  
>  static long bus_error_jmp[JMP_BUF_LEN];
> -- 
> 2.17.1
