From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 10:59:16 +0200
Message-ID: <ZHW65KTxiZKHFbOZ@alley>
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1685437157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G22ruJ68JY2gjnCl3J/tk16VWb8N9hrSL5V+P1DY8aw=;
	b=spkBo6kek5HXdJ+Ps51CIj7ivCB0CzLzZ+qf2jaG3s+TPpMFEjTLYiFju5XMlrBwFA1K0E
	ec6IB2UKXhlGjyv9V3BGLpIWjbbNQyPzkn3ch1fhUERosZ5blbavla1uiDgDtAG4BNJSfo
	LIQKkwdK7g7X9Ap82aOyzpqYy8KIGbg=
Content-Disposition: inline
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Maninder Singh <maninder1.s@samsung.com>
Cc: nathanl@linux.ibm.com, bcain@quicinc.com, keescook@chromium.org, gary@garyguo.net, ustavoars@kernel.org, linux-kernel@vger.kernel.org, Onkarnath <onkarnath.1@samsung.com>, wedsonaf@google.com, npiggin@gmail.com, alex.gaynor@gmail.com, linux-hexagon@vger.kernel.org, ojeda@kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon 2023-05-29 16:43:36, Maninder Singh wrote:
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
> 
> Thus array size should be KSYM_NAME_LEN.
> 
> for hexagon it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
> 
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

As mentioned by Michael Ellerman for the 2nd patch, the right upstream
commit is:

b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")

> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

With the updated commit hash:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
