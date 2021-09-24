Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED24168B6
	for <lists+kvmarm@lfdr.de>; Fri, 24 Sep 2021 02:09:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 7774F4B17B;
	Thu, 23 Sep 2021 20:09:15 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6s6jfOgbwqdH; Thu, 23 Sep 2021 20:09:15 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 59A6D4B16C;
	Thu, 23 Sep 2021 20:09:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A1A734B12C
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 20:09:12 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j6xfwHd37G8E for <kvmarm@lists.cs.columbia.edu>;
 Thu, 23 Sep 2021 20:09:11 -0400 (EDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A15454B116
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 20:09:11 -0400 (EDT)
Received: by mail-pl1-f169.google.com with SMTP id j15so3671238plh.7
 for <kvmarm@lists.cs.columbia.edu>; Thu, 23 Sep 2021 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rDmU+Q2B4PTbdip8cERFEgEFFT0D1k5kz4h+kRWhpfk=;
 b=SU3oAtVHe07oGmo26bqQMJMe+Q0hpLVga9WeYDmQHt++cXj3hLG+Yu5UxmVUdJ8Pnr
 ypdIByJqjemMIe4REY3hpKf1R4vMd9Mo3SDsXP2lT5chzna2/1LZaWROnjL3BY7ym6sk
 57ionAdRegLUZlVSAfjF461WQ0V05+muV7IDGUKaWU/jaHPJoUJnInB/o0BiUj/160kk
 AtYAYRKC+dRP0XxGLTC6aw0VwgLfgl6Dl7R8JC1dgH4SONPZw/gPt5jb5J5K5xMxy4/B
 N2S1gcrN8JG0eEmWjKAZUYVHwRkKB1qOvcs8ZaNuSd8E1MTPFR+T4qAYXt8g02V9OPIV
 TeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rDmU+Q2B4PTbdip8cERFEgEFFT0D1k5kz4h+kRWhpfk=;
 b=ZGAlbUp/xHYylIEoGpJM7GFwZlxQGzXanszyXa5VIxSqV0eiingNvTrp8c53QcpwB1
 px/UaIBekVOnEzFdQjaqKlTSBUZQMYkXnm6DRwiLQBtzk0d4nZVXJurbrp8icfLRCTX9
 IUJ/njg1TxgEhY6IteH/xQ8090bZ7nNKoI7NvpTTHPZreBJvjss9yEwOq6rQjyZIFStm
 NVyIsndmPecX16yQPLxww8nknG0fLOguDMjWdh/iaxCWll9zy3OJNMLzfj+JlCvMiFnN
 0bilnWncyew/3oYA3YQ5Ninf0HhqNuS8ZAhBDeOHYyIZR593A1vS0zR6SbaogeMaUWBh
 XM0g==
X-Gm-Message-State: AOAM5309baknuPX3CG5I2aban/Eyhy/fLnfNK5DeOE4W5iJsfquSXQVb
 mFGtpesH7BBi95pcEElVNW4fMWGtParXMg==
X-Google-Smtp-Source: ABdhPJwKwFjLIpgL7YxVwt8hXUT+iYGdH0WDrQ3+AV+hRzPJtyhDQOH1n4/VDpkBlA5z3IpZ7cErYg==
X-Received: by 2002:a17:902:ce83:b0:13b:67d5:2c4e with SMTP id
 f3-20020a170902ce8300b0013b67d52c4emr6610278plg.45.1632442150466; 
 Thu, 23 Sep 2021 17:09:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com.
 [35.185.214.157])
 by smtp.gmail.com with ESMTPSA id 4sm6310318pjb.21.2021.09.23.17.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 17:09:09 -0700 (PDT)
Date: Fri, 24 Sep 2021 00:09:06 +0000
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] selftests: KVM: Call ucall_init when setting up in
 rseq_test
Message-ID: <YU0XIoeYpfm1Oy0j@google.com>
References: <20210923220033.4172362-1-oupton@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923220033.4172362-1-oupton@google.com>
Cc: kvm@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
 Jim Mattson <jmattson@google.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Sep 23, 2021, Oliver Upton wrote:
> While x86 does not require any additional setup to use the ucall
> infrastructure, arm64 needs to set up the MMIO address used to signal a
> ucall to userspace. rseq_test does not initialize the MMIO address,
> resulting in the test spinning indefinitely.
> 
> Fix the issue by calling ucall_init() during setup.
> 
> Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
> Signed-off-by: Oliver Upton <oupton@google.com>
> ---
>  tools/testing/selftests/kvm/rseq_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 060538bd405a..c5e0dd664a7b 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -180,6 +180,7 @@ int main(int argc, char *argv[])
>  	 * CPU affinity.
>  	 */
>  	vm = vm_create_default(VCPU_ID, 0, guest_code);
> +	ucall_init(vm, NULL);

Any reason not to do this automatically in vm_create()?  There is 0% chance I'm
going to remember to add this next time I write a common selftest, arm64 is the
oddball here.
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
