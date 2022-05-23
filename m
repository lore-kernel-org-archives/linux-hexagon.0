From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/5] kallsyms: make kallsym APIs more
 safe with scnprintf
Date: Mon, 23 May 2022 12:39:12 -0700
Message-ID: <202205231238.FAF6D28@keescook>
References: <CGME20220520083715epcas5p400b11adef4d540756c985feb20ba29bc@epcas5p4.samsung.com>
 <20220520083701.2610975-1-maninder1.s@samsung.com>
 <YonTOL4zC4CytVrn@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9i0mf5EWjId+dJhDG42zI0t8gO1U5xR/fPTtg8h/guQ=; b=Y8InpWb+DYZbnct1Ov/S6EBxzp
 en1KVkagrIwwlLcfXizgG7Hj9dC3lGKNnoMqjBReKUfWQoWyKFQP0Q3llXh8bP7eHaLr7Df7fSd5w
 UPoRa+P7SXSsajDgyUBGiZLaWs6XnlEMn0A7VDj67POpac42EfRGQ9DXof1KRtm3mkHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9i0mf5EWjId+dJhDG42zI0t8gO1U5xR/fPTtg8h/guQ=; b=AiTb+c0SmlA7NzSmk/kWolEBmq
 VMKeHfBn4o09eXAT54z3gLp0RLdL1+T2Z8Ik/vSmXadTQqzGFDD8/Hr5tT50AOcD8z4TLa/CLPQ15
 /5w2EMIbtdgaJiXyzN3JS8VtjtCibk3KuJmeX0L4sHh8wZHpUxfhTUR3nHLOG+PaMO5E=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9i0mf5EWjId+dJhDG42zI0t8gO1U5xR/fPTtg8h/guQ=;
 b=G67mgEOcbKAzzfRqWT2tyqM6K9pitcq9pbTVcwT0LjmKZNi0oiqVsX8V97hEFwl2hf
 AMnpF3tfbp0thJvNCE4CX5dI4O8ELTGwmxs1K5fhCNP737yCqZGbfIr/xW9c33Xf+LOK
 scdJ+18kS7hWnfRSUS9ItgijmeteaopgZF3uU=
Content-Disposition: inline
In-Reply-To: <YonTOL4zC4CytVrn@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: peterz@infradead.org, benh@kernel.crashing.org, linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org, paulus@samba.org, linux-hexagon@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, linux-s390@vger.kernel.org, daniel.thompson@linaro.org, arnd@arndb.de, linux-scsi@vger.kernel.org, onkarnath.1@samsung.com, mpe@ellerman.id.au, anil.s.keshavamurthy@intel.com, kartilak@cisco.com, kgdb-bugreport@lists.sourceforge.net, naveen.n.rao@linux.ibm.com, longman@redhat.com, borntraeger@linux.ibm.com, jejb@linux.ibm.com, mhiramat@kernel.org, v.narang@samsung.com, pmladek@suse.com, satishkh@cisco.com, boqun.feng@gmail.com, gor@linux.ibm.com, hca@linux.ibm.com, rostedt@goodmis.org, linux-fsdevel@vger.kernel.org, andriy.shevchenko@linux.intel.com, mingo@redhat.com, bcain@quicinc.com, martin.petersen@oracle.com, sebaddel@cisco.com, senozhatsky@chromium.org, mcgrof@kernel.org, sve

On Sat, May 21, 2022 at 11:07:52PM -0700, Christoph Hellwig wrote:
> On Fri, May 20, 2022 at 02:06:56PM +0530, Maninder Singh wrote:
> > kallsyms functionality depends on KSYM_NAME_LEN directly.
> > but if user passed array length lesser than it, sprintf
> > can cause issues of buffer overflow attack.
> > 
> > So changing *sprint* and *lookup* APIs in this patch set
> > to have buffer size as an argument and replacing sprintf with
> > scnprintf.
> 
> This is still a pretty horrible API.  Passing something like
> a struct seq_buf seems like the much better API here.  Also with
> the amount of arguments and by reference passing it might be worth
> to pass them as a structure while you're at it.

Yeah, I agree. It really seems like seq_buf would be nicer.

-- 
Kees Cook
