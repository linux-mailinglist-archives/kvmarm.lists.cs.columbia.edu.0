Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 115AC65BA02
	for <lists+kvmarm@lfdr.de>; Tue,  3 Jan 2023 05:22:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 285BB4BB6D;
	Mon,  2 Jan 2023 23:22:12 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: -1.789
X-Spam-Level: 
X-Spam-Status: No, score=-1.789 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, RCVD_IN_DNSWL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
	T_DKIM_INVALID=0.01, URIBL_BLOCKED=0.001] autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@os.amperecomputing.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMZeILrEo1VC; Mon,  2 Jan 2023 23:22:12 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id AE67C4BB7F;
	Mon,  2 Jan 2023 23:22:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id D55D14BB5E
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Jan 2023 23:22:09 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KonUQ+LVq2q1 for <kvmarm@lists.cs.columbia.edu>;
 Mon,  2 Jan 2023 23:22:08 -0500 (EST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2111.outbound.protection.outlook.com [40.107.100.111])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 45B9C4BB41
 for <kvmarm@lists.cs.columbia.edu>; Mon,  2 Jan 2023 23:22:08 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc54pDDakMpaJTC18prjr6MBQDBz4eea+iSC3rAu7k1D9DbB4tCNxOVQ24Q018po8IFv33EbCr4UuKcNqMv0WhJSs/5h8HUAet/DTXhurX1f2tK5rBMGwvRVZRsrlHoPOALzNMQu4DFRMJ8LFOdQotBPiHgEMmDsdIIPOek0AY/k9qmjKveFPt9U7Mzc8zjRTE/zJ27cjcMEBChYGX3+PlFjrvGb98/hIJja3UMYIsGq43MBhNtKFn6xbHzZ0pY8//O5aSm++2AH3p4CU2qGOXTHGNIu4zJo9KREE7KnIfs+oXJF6Ns2pwoY6tZ7fSjKmwxVUYs+hfoYnLpD6iCspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJX+e8jWq83mExwloS4S210BaWcDOPyH4xLNHWN3INk=;
 b=g4LK0AgJUIFaf4sHlhIbHU1WJIJRvEAkzGlP3RHGuPpSSOI03cd+oMV0iCI0ohQzecbBalg9C9pTYNslOY+hl4isQGUPGlWJpTv/98nW+bLeOSAupntPsf2arV+RMtlJGeOYwxwE8Nvj/Pg+1aLAoqxZ5VTk7KYlHv/AekQ9+JA7lhY7nKMv4DnuDPOmPDqQrdtGqSEL7MemvWZ3eBp/sAjTV6BzjPAH34aILJKAUXcBcRaZm+sCEr6NWT+hHvV35tUdRVwtTDy5kNEOeCYqF9kSToo9gP1MYoWjpJh7n4fXwPJCVF9h4hjfDaJuZnu6NCpo8A3KfJR8MBfoDKGpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJX+e8jWq83mExwloS4S210BaWcDOPyH4xLNHWN3INk=;
 b=E5qCmJDiwrKvGrUitDzJ8nGuZU0t4c5a8yMmIpgTauc7SxuBFI/TnJDA+Ap049NjOLoEYG/zCcbW0lsG0JIq8hD0h6SVQuIl3rUVcSnQRAAF5kfceiNVgToNR39rL+6N8F27LfdCeYy/3sRQ2ABnpOIBUoad9/nm/1KoCzIjgGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CY4PR0101MB3158.prod.exchangelabs.com (2603:10b6:910:43::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Tue, 3 Jan 2023 04:22:03 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 04:22:03 +0000
Message-ID: <77a0523b-4bf5-5625-3f11-9b8e277b3a70@os.amperecomputing.com>
Date: Tue, 3 Jan 2023 09:51:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] KVM: arm64: nv: Emulate ISTATUS when emulated timers
 are fired.
To: Marc Zyngier <maz@kernel.org>
References: <20220824060304.21128-1-gankulkarni@os.amperecomputing.com>
 <20220824060304.21128-3-gankulkarni@os.amperecomputing.com>
 <87y1qqe2pg.wl-maz@kernel.org> <867cy5b1mq.wl-maz@kernel.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <867cy5b1mq.wl-maz@kernel.org>
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|CY4PR0101MB3158:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abf80b8-d364-4392-6dcd-08daed4210b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Knp2ARGrjq0VAxAK62pMB9nFg3TAeG6ZN9yqi0ymGqn7EiCEnF6VKmQqRoHasJtZ5h+4d3rCpIo0WcgpACPfNKnpxUTXIZ+frN2ujf8in/+DcXCMmZmy3GNEFuAtEwqwdBGYKlwKgxAgCdsFdxNUDvRTTSigciFubKRAK6dHViB+f8hhDk4icw34RsmAb9m68uI7OSLvvCWfrUfDF2VzGj9goEw891QQRukZRfc4OQkEHLysi/KqwU/25PLXTPvo8NoStReh6DihhrAXp3hAT/pk8XQ49QzfaylHOloGazv+oxM98J3rTxQgHjHhIr+ZmbSJnUUPVURGzD3mJd/AZSNhyXbzYx2XquGtW92iBYKLyxg2qF8u8upavZTKo7+LfM49zWTIlL/Dz9lJ5+xlzVOK/rfc3ymnpPwrgtt1JASOzbyotxeGyJ+8CLsM2r+uzXc110qZfuxnXa5u+R0f5S1KxJoZ8qeCPenvf5KS4AXBciHNqT7gN1tEXjvaFhkvAVxu+2o7M7hRGIE0Oh63oSL/Iq69cYEFck2UHmAQSMjrBN/gcK2T5TyOuWGm+IdryKIneEYPU2mqHTx+ysbFM+mLGH8cmfC9Aih8BdN7MIrIzhax0cKFpxGK7HzBDfepjPnqsQDugSI/KhXedjsPw5lfvN5gcTxm1wzGqyzmdpORY8M+Sb9dc7vR2QiwUbOE3uiwXFwJS8cT1sy186qX/Y4tK+SzPLWHf5nb9z/mbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR01MB6824.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(451199015)(478600001)(38100700002)(6486002)(83380400001)(6506007)(53546011)(107886003)(6666004)(6512007)(2616005)(26005)(186003)(31686004)(8936002)(5660300002)(8676002)(4326008)(66476007)(66946007)(66556008)(41300700001)(6916009)(2906002)(31696002)(316002)(86362001)(22166006)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJwUk9KZjVYSG5ycTk2TWk3SGEzaWp0b2dQVkdsQ0RpakJQSFpWUVpCRkNo?=
 =?utf-8?B?WERiTGVINHNiS05zWW8wdGlKM09GVUFFOUlPU2psMUF5aEJXRlQ4cGxpM2N1?=
 =?utf-8?B?Tkp1QnNJcWQ3RnF1S3Z0NnRRRW9RVmlCL01kSUFBdUowbUtYV1lCdWJERGo3?=
 =?utf-8?B?SzEzUHI2ZngzSmx3MDRBeHpXVlhScWtDT3E3dTE2ZlJMUkRnbW9oL1pmelRM?=
 =?utf-8?B?V1JjOEZ5VGwvdDliazZKa1lCZXlOZjZPYkI1blFlcDVsRzRvajEvU1J4bGdw?=
 =?utf-8?B?RWRBOWRONnB2L0NzRDYvaTl4WHhZS0Y2aFNxMFh4V3pVMXBsUkhoMDBtT0ww?=
 =?utf-8?B?T1BuTGgrMDluRXVNWlFucTdyUklIUjlNM3VUS3F0Z0J1eXliSTUxczhaVmw0?=
 =?utf-8?B?RSsvVytmOGlxRVd4UTZ2b1lsZVFKNU1xditydDdtblgyblM2akhFVU1Bek9Z?=
 =?utf-8?B?dHJnKzB4bXA5VmViRlBJVHpFUzZ6U3RVMy95R3pVZE01eHZQZmxHZkN1dUZt?=
 =?utf-8?B?ZUE4S1lyMzNCOVhqWnFvdFNaVTFhcmFSdVhhWWwxMFNqanhpS3JkdUdTRVpj?=
 =?utf-8?B?TEY5cW51RjdlV1B0SHc0L3dNWnJxSWEzcDJRTnEwVUpIVGp0djlQRHgreTMy?=
 =?utf-8?B?WE05RzlKaXYvdmNhdmtyV05zRVFTcUJBMnJ6ZHl0MytCbDdOQ1BaaUxpbVUr?=
 =?utf-8?B?a2VtWm9YbE9FZ0VvVzBsUUI3MzBKaFYzUTY2OEt3OVA1dzJLRU5ob3BCZGJP?=
 =?utf-8?B?aXJXVWYwYmxLWDFTZ1BualJLTEZTanZxcjB6RnhoTzJUNDZCamlTYVNRYURO?=
 =?utf-8?B?UUtBT1F2eE5NRWVXcEU2N2RRaFlOM2Q2eUcvUFd3K3crTXZzaDEvNnJNYkdk?=
 =?utf-8?B?WVdlQVQ3SEREeDk1QzFRTnRtcFBlUDlsa0lsb25jcll1RGRBdW4zem9DUytH?=
 =?utf-8?B?cFNreUxQVkJ5ZlN1U3k4VXNjQ3dPVUJMSkx2ZDF0b1hFazltV0JUNWVja1hy?=
 =?utf-8?B?M3d1Z2MvcXFqUWROVnZvckxZWHJ0bGsrSHoySFlyR0p1SUowMm1XaG1pVVJV?=
 =?utf-8?B?L3EvT0pRamVIakZWRk1Ed3FyekVJSGh5UHVXcDU2ZS9QU0V5WHpsZ3NVVEdM?=
 =?utf-8?B?NExvcXprcnBLYzN4M0swbUE2M2t2SkdRNndncUtiKzBDdVdQK3d1YWV6TFdp?=
 =?utf-8?B?dlpQSzd4LzQxT3R4VVpMMUxqYzY3OVVNTFlWdTNzZU1VZTR2NThYTDFVQ0Yy?=
 =?utf-8?B?bk9FcWR4eW81NDI5V2s0R2tuaGgvWjRzRTQzd1JNR2ZINXlIbUNZVHFQSVhC?=
 =?utf-8?B?ZzRuUEs4eWhUK3g2SFpOak4zRXhyWWZaWFdGZGJmdUVKMDFUQXlra2liR2FR?=
 =?utf-8?B?MlFQbC9ueTlsVFZtYnFLVHhCMks4cmRFYm01MFdCNzFnZXhzM3Fwc0dCWG9s?=
 =?utf-8?B?NytwZWljRnhVejhuUWhuUkFLdkFVVGxuR240YWU1bmx4RGNBWXFPUnQ5ZHZK?=
 =?utf-8?B?ZHV0dzQvUmxhekNzRUxrV1ZUcWZIK0NHbEd1akJjT0M4dDNla1VVUzVXeUoy?=
 =?utf-8?B?VlpKeDFNNUUxOXZWanhvbC9oVitaYzZPeEFzVTdvNUlSQlFEb25qR3pwM2Zi?=
 =?utf-8?B?RFE0dmczazNHYjZ1ZDgzS1gyTmRMaUhMc244NU5mMkRURkxpNytUblNkVGUy?=
 =?utf-8?B?b3dWbWROMURya1B6UFNUQTBSQmF3VzFmZW5pSWU5WTQxMHRsMjBwemVGUWxh?=
 =?utf-8?B?RXdhcnJaMW5PYzV3QTN1YU1WeWdOZ2NqTlFIc2dXNWpZVHRDeDRmaHpUT3BF?=
 =?utf-8?B?L3B4QjgrTjlVUXB5eUd6K2VwcFJSZTN5bmlkMHJuR1J6VmNJN25ObHJsTVpX?=
 =?utf-8?B?YndvN2Nyd1hqRnF6bjVCNWI5UnpFekphcXg5dnFGL2F4ZU5zc2hwTjhaQm5Y?=
 =?utf-8?B?M0pVUUI3YnBqczFwYVhnd3F4MmZPZEtWMnhnejd1VGptSUNWajg5ZjI3T1RQ?=
 =?utf-8?B?bEVNWTJ4Zitadi9CdUxrTzgzR016c0IwN1grdk9OYVFEUng4S2gwQXYyZ0s2?=
 =?utf-8?B?djBlME5aeVF2MFVIVGw5bExya0NTcjM2WG9EZ0xhcFlYT3MxTzgzR3FSdG5S?=
 =?utf-8?B?MkVuUGVGanFvNGdQakcvVmJYNkFjSkhoQnpKa0hLdjVXd3JtVVgybm9tSzhI?=
 =?utf-8?Q?qUGP9PPTLidjkPj/820N62ymyt+H8Dz0nJr+jcExKS/p?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abf80b8-d364-4392-6dcd-08daed4210b8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 04:22:03.5335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwXpihem75Z4UQuim49GIrWwgsTPzf5ar/fbuHNvkx4mJuYzH0bjCSSF+BsqZ+i/dLJmbY55r/FJi73JlRD7nYJNoYGBP1IDFlZC3Kr481L0UTESsx5BslnOuxtyUCiw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0101MB3158
Cc: scott@os.amperecomputing.com, kvm@vger.kernel.org, catalin.marinas@arm.com,
 darren@os.amperecomputing.com, will@kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu



On 02-01-2023 05:16 pm, Marc Zyngier wrote:
> On Thu, 29 Dec 2022 13:53:15 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Wed, 24 Aug 2022 07:03:03 +0100,
>> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>>
>>> Guest-Hypervisor forwards the timer interrupt to Guest-Guest, if it is
>>> enabled, unmasked and ISTATUS bit of register CNTV_CTL_EL0 is set for a
>>> loaded timer.
>>>
>>> For NV2 implementation, the Host-Hypervisor is not emulating the ISTATUS
>>> bit while forwarding the Emulated Vtimer Interrupt to Guest-Hypervisor.
>>> This results in the drop of interrupt from Guest-Hypervisor, where as
>>> Host Hypervisor marked it as an active interrupt and expecting Guest-Guest
>>> to consume and acknowledge. Due to this, some of the Guest-Guest vCPUs
>>> are stuck in Idle thread and rcu soft lockups are seen.
>>>
>>> This issue is not seen with NV1 case since the register CNTV_CTL_EL0 read
>>> trap handler is emulating the ISTATUS bit.
>>>
>>> Adding code to set/emulate the ISTATUS when the emulated timers are fired.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/kvm/arch_timer.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
>>> index 27a6ec46803a..0b32d943d2d5 100644
>>> --- a/arch/arm64/kvm/arch_timer.c
>>> +++ b/arch/arm64/kvm/arch_timer.c
>>> @@ -63,6 +63,7 @@ static u64 kvm_arm_timer_read(struct kvm_vcpu *vcpu,
>>>   			      struct arch_timer_context *timer,
>>>   			      enum kvm_arch_timer_regs treg);
>>>   static bool kvm_arch_timer_get_input_level(int vintid);
>>> +static u64 read_timer_ctl(struct arch_timer_context *timer);
>>>   
>>>   static struct irq_ops arch_timer_irq_ops = {
>>>   	.get_input_level = kvm_arch_timer_get_input_level,
>>> @@ -356,6 +357,8 @@ static enum hrtimer_restart kvm_hrtimer_expire(struct hrtimer *hrt)
>>>   		return HRTIMER_RESTART;
>>>   	}
>>>   
>>> +	/* Timer emulated, emulate ISTATUS also */
>>> +	timer_set_ctl(ctx, read_timer_ctl(ctx));
>>
>> Why should we do that for non-NV2 configurations?
>>
>>>   	kvm_timer_update_irq(vcpu, true, ctx);
>>>   	return HRTIMER_NORESTART;
>>>   }
>>> @@ -458,6 +461,8 @@ static void timer_emulate(struct arch_timer_context *ctx)
>>>   	trace_kvm_timer_emulate(ctx, should_fire);
>>>   
>>>   	if (should_fire != ctx->irq.level) {
>>> +		/* Timer emulated, emulate ISTATUS also */
>>> +		timer_set_ctl(ctx, read_timer_ctl(ctx));
>>>   		kvm_timer_update_irq(ctx->vcpu, should_fire, ctx);
>>>   		return;
>>>   	}
>>
>> I'm not overly keen on this. Yes, we can set the status bit there. But
>> conversely, the bit will not get cleared when the guest reprograms the
>> timer, and will take a full exit/entry cycle for it to appear.
>>
>> Ergo, the architecture is buggy as memory (the VNCR page) cannot be
>> used to emulate something as dynamic as a timer.
>>
>> It is only with FEAT_ECV that we can solve this correctly by trapping
>> the counter/timer accesses and emulate them for the guest hypervisor.
>> I'd rather we add support for that, as I expect all the FEAT_NV2
>> implementations to have it (and hopefully FEAT_FGT as well).
> 
> So I went ahead and implemented some very basic FEAT_ECV support to
> correctly emulate the timers (trapping the CTL/CVAL accesses).
> 
> Performance dropped like a rock (~30% extra overhead) for L2
> exit-heavy workloads that are terminated in userspace, such as virtio.
> For those workloads, vcpu_{load,put}() in L1 now generate extra traps,
> as we save/restore the timer context, and this is enough to make
> things visibly slower, even on a pretty fast machine.
> 
> I managed to get *some* performance back by satisfying CTL/CVAL reads
> very early on the exit path (a pretty common theme with NV). Which
> means we end-up needing something like what you have -- only a bit
> more complete. I came up with the following:
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 4945c5b96f05..a198a6211e2a 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -450,6 +450,25 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level,
>   {
>   	int ret;
>   
> +	/*
> +	 * Paper over NV2 brokenness by publishing the interrupt status
> +	 * bit. This still results in a poor quality of emulation (guest
> +	 * writes will have no effect until the next exit).
> +	 *
> +	 * But hey, it's fast, right?
> +	 */
> +	if (vcpu_has_nv2(vcpu) && is_hyp_ctxt(vcpu) &&
> +	    (timer_ctx == vcpu_vtimer(vcpu) || timer_ctx == vcpu_ptimer(vcpu))) {
> +		u32 ctl = timer_get_ctl(timer_ctx);
> +
> +		if (new_level)
> +			ctl |= ARCH_TIMER_CTRL_IT_STAT;
> +		else
> +			ctl &= ~ARCH_TIMER_CTRL_IT_STAT;
> +
> +		timer_set_ctl(timer_ctx, ctl);
> +	}
> +
>   	timer_ctx->irq.level = new_level;
>   	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer_ctx->irq.irq,
>   				   timer_ctx->irq.level);
> 
> which reports the interrupt state in all cases.
> 
> Does this work for you?

Thanks Marc for the patch. I will try this and update at the earliest.

> 
> Thanks,
> 
> 	M.
> 

Thanks,
Ganapat
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
