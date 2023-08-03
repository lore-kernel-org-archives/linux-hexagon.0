From: Benjamin Gray <bgray@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
Date: Thu, 3 Aug 2023 15:46:10 +1000
Message-ID: <dc30eea1-a977-7ee2-9975-d623ba401c84@linux.ibm.com>
References: <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
 <20230529111337.352990-2-maninder1.s@samsung.com>
 <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dRolJn+krV/ITKG1jffzCOnmUCoH4C2lfFRoAe9Al0U=;
 b=QVGIak8nQY7yNvy3wIg89QKOK9wqvwLEq/hrkWJUJuieqGhH+CIn1B73DOMnOApZyFY0
 t3Q898wKJtm4HlTwUFUSLMVoEZkWQHnF/bwz436Dz/6a7lrLWsApo04ebQ7bNVrEKnEe
 qLKc9hU1yuomASOr42/AazAPXwIQCFV1S3biiNjy9jUdAqqGfTPpFOxWhHfMCWNxgDgS
 TiQRzJurxhX3RpOW+xxOeY4i6ZOnIFru/xLrOd2D1xjOq3IqiSsw6tGTGf3tUbrpLgpR
 qS7vnX5S/imIhujZKn2/I+F10vqBTz2AT/jaIgZs+743FlJ4D4SGrJBGYReXyBQqSbwH CA== 
Content-Language: en-US, en-AU
In-Reply-To: <CANiq72=QeTgtZL4k9=4CJP6C_Hv=rh3fsn3B9S3KFoPXkyWk3w@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maninder Singh <maninder1.s@samsung.com>
Cc: nathanl@linux.ibm.com, bcain@quicinc.com, keescook@chromium.org, gary@garyguo.net, pmladek@suse.com, ustavoars@kernel.org, linux-kernel@vger.kernel.org, Onkarnath <onkarnath.1@samsung.com>, wedsonaf@google.com, npiggin@gmail.com, alex.gaynor@gmail.com, linux-hexagon@vger.kernel.org, ojeda@kernel.org, linuxppc-dev@lists.ozlabs.org

On 30/5/23 10:54 pm, Miguel Ojeda wrote:
> Side-note: in `get_function_bounds()`, I see `kallsyms_lookup()` being
> used, but the name seems discarded? Can
> `kallsyms_lookup_size_offset()` be used instead, thus avoiding the
> usage of the buffer there to begin with?

I'm not familiar with the kallsyms infrastructure, but looking over the 
implementations of kallsyms_lookup() and kallsyms_lookup_size_offset() 
it looks like the existing kallsyms_lookup()
  handles an extra case over kallsyms_lookup_size_offset()?

kallsyms_lookup_buildid() (the implementation of kallsyms_lookup()) has

   /* See if it's in a module or a BPF JITed image. */
   ret = module_address_lookup(addr, symbolsize, offset,
                               modname, modbuildid, namebuf);
   if (!ret)
           ret = bpf_address_lookup(addr, symbolsize,
                                    offset, modname, namebuf);

   if (!ret)
           ret = ftrace_mod_address_lookup(addr, symbolsize,
                                           offset, modname, namebuf);

while kallsyms_lookup_size_offset() is missing the ftrace case

   return !!module_address_lookup(addr, symbolsize, offset,
                                  NULL, NULL, namebuf) ||
          !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);

Might this be a concern for xmon?
