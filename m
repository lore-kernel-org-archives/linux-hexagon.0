From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
Date: Mon, 03 Jul 2023 14:02:49 +1000
Message-ID: <168835696947.31199.7769783904677561364.b4-ty@ellerman.id.au>
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com> <20230529111337.352990-1-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Maninder Singh <maninder1.s@samsung.com>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Onkarnath <onkarnath.1@samsung.com>

On Mon, 29 May 2023 16:43:36 +0530, Maninder Singh wrote:
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
> 
> Thus array size should be KSYM_NAME_LEN.
> 
> for hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
> 
> [...]

Patch 2 applied to powerpc/fixes.

[2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
      https://git.kernel.org/powerpc/c/719dfd5925e186e09a2a6f23016936ac436f3d78

cheers
